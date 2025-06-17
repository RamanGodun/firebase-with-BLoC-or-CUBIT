part of '_app_theme_type.dart.dart';

/// 🌓 [AppThemeMode] — Represents base typography configuration
/// 💡 Used to switch light/dark [TextTheme] factories

enum AppThemeMode {
  //----------------

  light(TextStyleFactory.light),
  dark(TextStyleFactory.dark);

  final TextStyleFactory builder;

  const AppThemeMode(this.builder);

  //
}
