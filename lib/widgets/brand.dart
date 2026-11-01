import 'package:flutter/material.dart';

/// The Q-and-heart mark, recoloured to the current theme.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 32, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).colorScheme.primary;
    return Image.asset(
      'assets/logo_mark.png',
      width: size,
      height: size,
      color: c,
      colorBlendMode: BlendMode.srcIn,
      errorBuilder: (_, __, ___) => Icon(Icons.favorite_border, size: size, color: c),
    );
  }
}

/// QUOTIDIAN wordmark in the logo's spaced capitals.
class BrandWordmark extends StatelessWidget {
  const BrandWordmark({super.key, this.size = 15, this.tagline = false});

  final double size;
  final bool tagline;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUOTIDIAN',
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.w700,
            letterSpacing: size * 0.28,
            color: cs.primary,
            height: 1.1,
          ),
        ),
        if (tagline)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              'Simplified Living & Wellness',
              style: TextStyle(fontSize: size * 0.72, color: cs.onSurfaceVariant),
            ),
          ),
      ],
    );
  }
}
