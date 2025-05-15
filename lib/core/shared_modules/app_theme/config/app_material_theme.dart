import 'package:flutter/material.dart';

/// 🎛️ [AppThemeConfig] — Typed container for app-wide theming settings
/// ✅ Used by `MaterialApp`:
//-------------------------------------------------------------

@immutable
final class AppThemeConfig {
  final String title;
  final bool debugShowCheckedModeBanner;
  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  const AppThemeConfig({
    required this.title,
    required this.debugShowCheckedModeBanner,
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
  });
}
