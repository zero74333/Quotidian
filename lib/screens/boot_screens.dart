import 'package:flutter/material.dart';

import '../diagnostics.dart';
import '../widgets/brand.dart';

/// Shown while the database opens.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BrandMark(size: 110),
            const SizedBox(height: 18),
            const BrandWordmark(size: 22, tagline: true),
            const SizedBox(height: 28),
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shown instead of a blank screen if the database cannot be opened.
class BootErrorScreen extends StatelessWidget {
  const BootErrorScreen({super.key, required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrandMark(size: 72),
                const SizedBox(height: 18),
                Text('Quotidian could not open your data',
                    style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                Text(
                  'Nothing has been deleted. Close other apps, make sure the phone has free '
                  'storage, then try again.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 12),
                Text(message,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try again'),
                ),
                if (!ErrorLog.isEmpty) ...[
                  const SizedBox(height: 8),
                  Text('${ErrorLog.count} error(s) recorded',
                      style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant)),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Lays the lock screen over the whole app, including any open pages.
class LockLayer extends StatefulWidget {
  const LockLayer({super.key, required this.child});

  final Widget child;

  @override
  State<LockLayer> createState() => _LockLayerState();
}

class _LockLayerState extends State<LockLayer> {
  late final OverlayEntry _entry = OverlayEntry(builder: (_) => widget.child);

  @override
  void dispose() {
    _entry.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Overlay(initialEntries: [_entry]),
    );
  }
}
