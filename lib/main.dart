import 'dart:ui' show PlatformDispatcher;

import 'package:flutter/material.dart';

import 'app_state.dart';
import 'database.dart';
import 'diagnostics.dart';
import 'screens/boot_screens.dart';
import 'screens/lock_screen.dart';
import 'screens/shell.dart';
import 'theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Record errors instead of crashing silently; show a calm placeholder
  // for any widget that fails to build.
  FlutterError.onError = (details) {
    ErrorLog.add(details.exception, details.stack);
    FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    ErrorLog.add(error, stack);
    return true;
  };
  ErrorWidget.builder = (details) {
    ErrorLog.add(details.exception, details.stack);
    return const Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Text(
            'This part could not be shown.\nYour data is safe.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF8592A8), fontSize: 13),
          ),
        ),
      ),
    );
  };

  runApp(const QuotidianApp());
}

enum _Phase { loading, ready, failed }

class QuotidianApp extends StatefulWidget {
  const QuotidianApp({super.key});

  @override
  State<QuotidianApp> createState() => _QuotidianAppState();
}

class _QuotidianAppState extends State<QuotidianApp> with WidgetsBindingObserver {
  _Phase _phase = _Phase.loading;
  String _error = '';
  DateTime? _pausedAt;
  String _openedToday = dateKey(DateTime.now());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _boot();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _boot() async {
    if (_phase != _Phase.loading) setState(() => _phase = _Phase.loading);
    try {
      await appState.init();
      await store.open(dateKey(DateTime.now()));
      _openedToday = dateKey(DateTime.now());
      if (mounted) setState(() => _phase = _Phase.ready);
    } catch (e, st) {
      ErrorLog.add(e, st);
      if (mounted) {
        setState(() {
          _phase = _Phase.failed;
          _error = e.toString();
        });
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_phase != _Phase.ready) return;
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      _pausedAt ??= DateTime.now();
      store.flush();
    } else if (state == AppLifecycleState.resumed) {
      final away = _pausedAt == null ? Duration.zero : DateTime.now().difference(_pausedAt!);
      _pausedAt = null;
      if (away > const Duration(seconds: 60)) {
        FocusManager.instance.primaryFocus?.unfocus();
        appState.lock();
      }
      // If the app stayed open past midnight, move Today to the new day.
      final today = dateKey(DateTime.now());
      if (today != _openedToday) {
        if (store.date == _openedToday) store.open(today);
        _openedToday = today;
      }
    }
  }

  Widget _home() {
    switch (_phase) {
      case _Phase.loading:
        return const SplashScreen();
      case _Phase.failed:
        return BootErrorScreen(message: _error, onRetry: _boot);
      case _Phase.ready:
        return const Shell();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appState,
      builder: (context, _) {
        return MaterialApp(
          title: 'Quotidian',
          debugShowCheckedModeBanner: false,
          themeMode: appState.theme,
          theme: lightTheme,
          darkTheme: darkTheme,
          builder: (context, child) {
            // Keep layouts stable when the phone uses very large text.
            final body = MediaQuery.withClampedTextScaling(
              minScaleFactor: 0.9,
              maxScaleFactor: 1.3,
              child: child ?? const SizedBox.shrink(),
            );
            return Stack(
              fit: StackFit.expand,
              children: [
                body,
                if (appState.locked && _phase == _Phase.ready)
                  const Positioned.fill(child: LockLayer(child: LockScreen())),
              ],
            );
          },
          home: _home(),
        );
      },
    );
  }
}
