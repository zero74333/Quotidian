import 'package:flutter/material.dart';

/// Soft outlined card used across the app (replaces the default shadowed Card).
class SoftCard extends StatelessWidget {
  const SoftCard({
    super.key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: margin,
      child: Material(
        color: cs.surfaceContainerLow,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: cs.outlineVariant),
        ),
        child: padding == null ? child : Padding(padding: padding!, child: child),
      ),
    );
  }
}

/// Icon tile used for the dashboard and for section pages.
class AppTile extends StatelessWidget {
  const AppTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    this.count = 0,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  /// Number of answers logged today (shows a badge when > 0).
  final int count;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final dark = Theme.of(context).brightness == Brightness.dark;
    // Slightly lighter icon colour on dark surfaces so it stays readable.
    final tint = dark ? Color.lerp(color, Colors.white, 0.35)! : color;
    return Material(
      color: cs.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: color.withAlpha(dark ? 60 : 38),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(icon, color: tint, size: 25),
                  ),
                  if (count > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$count',
                        style: const TextStyle(
                            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: tt.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

int gridColumns(BuildContext context) {
  final w = MediaQuery.of(context).size.width;
  if (w >= 900) return 4;
  if (w >= 600) return 3;
  return 2;
}

/// Tile height that grows with the phone's text size so nothing overflows.
double tileHeight(BuildContext context) {
  final s = MediaQuery.textScalerOf(context).scale(1.0);
  final clamped = s < 1.0 ? 1.0 : (s > 1.3 ? 1.3 : s);
  return 150.0 * clamped;
}

SliverGridDelegate tileGrid(BuildContext context) {
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: gridColumns(context),
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
    mainAxisExtent: tileHeight(context),
  );
}
