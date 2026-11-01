import 'package:flutter/material.dart';

import '../app_state.dart';
import '../widgets/brand.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final _c = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _try() {
    if (appState.checkPin(_c.text.trim())) {
      appState.unlock();
    } else {
      setState(() => _error = 'Wrong PIN. Try again.');
      _c.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const BrandMark(size: 84),
                  const SizedBox(height: 14),
                  const BrandWordmark(size: 20),
                  const SizedBox(height: 6),
                  Text('Enter your PIN to continue',
                      style: TextStyle(color: cs.onSurfaceVariant)),
                  const SizedBox(height: 22),
                  TextField(
                    controller: _c,
                    autofocus: true,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      labelText: 'PIN',
                      errorText: _error,
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _try(),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(onPressed: _try, child: const Text('Unlock')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
