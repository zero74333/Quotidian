import 'package:flutter/material.dart';

/// Colours taken from the Quotidian logo (navy line art on near-white).
class Brand {
  static const ink = Color(0xFF2A4C6F); // the logo navy
  static const sage = Color(0xFF3F8F86); // calm accent
  static const coral = Color(0xFFC9714F); // warm accent for gentle notices
}

ColorScheme _light() {
  return ColorScheme.fromSeed(seedColor: Brand.ink, brightness: Brightness.light).copyWith(
    primary: Brand.ink,
    onPrimary: Colors.white,
    primaryContainer: const Color(0xFFDCE7F5),
    onPrimaryContainer: const Color(0xFF12294A),
    secondary: Brand.sage,
    onSecondary: Colors.white,
    secondaryContainer: const Color(0xFFD9EEEA),
    onSecondaryContainer: const Color(0xFF0E3732),
    tertiary: Brand.coral,
    onTertiary: Colors.white,
    tertiaryContainer: const Color(0xFFFCE9E1),
    onTertiaryContainer: const Color(0xFF5A2A18),
    surface: const Color(0xFFF6F8FC),
    onSurface: const Color(0xFF14213A),
    onSurfaceVariant: const Color(0xFF55627A),
    surfaceContainerLowest: Colors.white,
    surfaceContainerLow: Colors.white,
    surfaceContainer: const Color(0xFFF0F4FA),
    surfaceContainerHigh: const Color(0xFFE9EEF6),
    surfaceContainerHighest: const Color(0xFFE1E8F2),
    outline: const Color(0xFF8592A8),
    outlineVariant: const Color(0xFFD6DEEA),
  );
}

ColorScheme _dark() {
  return ColorScheme.fromSeed(seedColor: Brand.ink, brightness: Brightness.dark).copyWith(
    primary: const Color(0xFFA9C4EE),
    onPrimary: const Color(0xFF0F2442),
    primaryContainer: const Color(0xFF28436B),
    onPrimaryContainer: const Color(0xFFD9E6FB),
    secondary: const Color(0xFF7CCBBF),
    onSecondary: const Color(0xFF06302B),
    secondaryContainer: const Color(0xFF1F4A45),
    onSecondaryContainer: const Color(0xFFC9EFE9),
    tertiary: const Color(0xFFF0A98D),
    onTertiary: const Color(0xFF4A1E0E),
    tertiaryContainer: const Color(0xFF5A2E1E),
    onTertiaryContainer: const Color(0xFFFFDACC),
    surface: const Color(0xFF0D1627),
    onSurface: const Color(0xFFE4EAF5),
    onSurfaceVariant: const Color(0xFFA3AFC6),
    surfaceContainerLowest: const Color(0xFF09111F),
    surfaceContainerLow: const Color(0xFF121C30),
    surfaceContainer: const Color(0xFF172339),
    surfaceContainerHigh: const Color(0xFF1D2B45),
    surfaceContainerHighest: const Color(0xFF25344F),
    outline: const Color(0xFF75839E),
    outlineVariant: const Color(0xFF2F3D58),
  );
}

ThemeData _build(ColorScheme cs, Brightness b) {
  final base = ThemeData(useMaterial3: true, colorScheme: cs, brightness: b);
  final tt = base.textTheme;
  final shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(14));
  return base.copyWith(
    scaffoldBackgroundColor: cs.surface,
    textTheme: tt.copyWith(
      headlineSmall: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.2),
      titleLarge: tt.titleLarge?.copyWith(fontWeight: FontWeight.w700),
      titleMedium: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
      labelLarge: tt.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(shape: shape, minimumSize: const Size(0, 46)),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: shape,
        minimumSize: const Size(0, 46),
        side: BorderSide(color: cs.outlineVariant),
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: cs.outlineVariant),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: cs.surfaceContainerLow,
      indicatorColor: cs.primaryContainer,
      labelTextStyle: const WidgetStatePropertyAll<TextStyle>(
        TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
  );
}

final ThemeData lightTheme = _build(_light(), Brightness.light);
final ThemeData darkTheme = _build(_dark(), Brightness.dark);

/// One accent per section. Muted, similar weight, harmonised with the navy.
class SectionColors {
  static const daily = Color(0xFF2A4C6F);
  static const health = Color(0xFF3A9A86);
  static const mind = Color(0xFF7B69C4);
  static const ideaverse = Color(0xFF4F6BD8);
  static const work = Color(0xFF2F7A99);
  static const money = Color(0xFF5B9A4B);
  static const social = Color(0xFFCF6A7E);
  static const habits = Color(0xFFDE8441);
  static const activities = Color(0xFFA25596);
  static const tools = Color(0xFF64748B);
}
