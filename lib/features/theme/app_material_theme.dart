import 'package:flutter/material.dart';

/// 🎛️ [AppThemeConfig] — Strongly typed theming config
@immutable
class AppThemeConfig {
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
