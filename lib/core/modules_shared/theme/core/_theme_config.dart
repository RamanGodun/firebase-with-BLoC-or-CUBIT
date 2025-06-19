import 'package:flutter/material.dart';
import 'app_themes.dart';
import '../theme_cubit/theme_cubit.dart';
import 'enums/_app_theme_type.dart.dart';

/// 🎯 [AppThemeBuilder] — Unified config builder for both Bloc and Riverpod.
/// ✅ Converts either ThemeMode (Riverpod) or AppThemeState (Bloc) into AppThemeConfig.

@immutable
final class AppThemeBuilder {
  ///----------------------
  const AppThemeBuilder._();

  /// 🧩 Factory from Bloc state (AppThemeState)
  static AppThemesScheme from(AppThemeState state) {
    final mode = state.isDarkTheme ? ThemeMode.dark : ThemeMode.light;
    return fromMode(mode);
  }

  /// 🧩 Factory from ThemeMode (used in Riverpod)
  static AppThemesScheme fromMode(ThemeMode mode) {
    return AppThemesScheme(
      light: AppThemes.resolve(AppThemeType.light),
      darkTheme: AppThemes.resolve(AppThemeType.dark),
      mode: mode,
    );
  }

  /// 🧩 Fallback: default system mode
  static AppThemesScheme fallback() => fromMode(ThemeMode.system);

  //
}

/// 🎨 [AppThemesScheme] — Theme container passed into MaterialApp
/// ✅ Holds light/dark themes and current ThemeMode.

@immutable
final class AppThemesScheme {
  /// ─────-----------------

  final ThemeData light;
  final ThemeData darkTheme;
  final ThemeMode mode;

  const AppThemesScheme({
    required this.light,
    required this.darkTheme,
    required this.mode,
  });
}
