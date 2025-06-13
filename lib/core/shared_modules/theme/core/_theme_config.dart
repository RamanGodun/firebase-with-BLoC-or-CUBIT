import 'package:flutter/material.dart';
import 'app_themes.dart';
import '../theme_cubit/theme_cubit.dart';
import 'enums/_app_theme_type.dart.dart';

/// 🎯 [ThemeConfig] — Unified config builder for both Bloc and Riverpod.
/// ✅ Converts either ThemeMode (Riverpod) or AppThemeState (Bloc) into AppThemeConfig.

@immutable
final class ThemeConfig {
  const ThemeConfig._();
  //----------------------

  /// 🧩 Factory from ThemeMode (used in Riverpod)
  static AppThemeConfig fromMode(ThemeMode mode) {
    return AppThemeConfig(
      theme: AppThemes.resolve(AppThemeType.light),
      darkTheme: AppThemes.resolve(AppThemeType.dark),
      themeMode: mode,
    );
  }

  /// 🧩 Factory from Bloc state (AppThemeState)
  static AppThemeConfig fromBloc(AppThemeState state) {
    final mode = state.isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    return fromMode(mode);
  }

  /// 🧩 Fallback: default system mode
  static AppThemeConfig fallback() => fromMode(ThemeMode.system);

  //
}

/// 🎨 [AppThemeConfig] — Theme container passed into MaterialApp
/// ✅ Holds light/dark themes and current ThemeMode.

@immutable
final class AppThemeConfig {
  /// ─────-----------------

  final ThemeData theme;
  final ThemeData darkTheme;
  final ThemeMode themeMode;

  const AppThemeConfig({
    required this.theme,
    required this.darkTheme,
    required this.themeMode,
  });
}
