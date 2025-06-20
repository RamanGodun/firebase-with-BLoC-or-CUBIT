import 'package:flutter/material.dart';
import '../theme_utils/theme_mode_adapter.dart';
import 'app_themes.dart';
import 'enums/_app_theme_type.dart.dart';

/// 🎯 [AppThemeBuilder] — Unified config builder for both Bloc and Riverpod.
/// ✅ Converts either ThemeMode (Riverpod) or AppThemeState (Bloc) into AppThemeConfig.

@immutable
final class AppThemeBuilder {
  ///----------------------
  const AppThemeBuilder._();
  //

  /// 🧩 Factory from ThemeMode (used in Riverpod)
  static AppThemesScheme from(IAppThemeState state) {
    return AppThemesScheme(
      light: AppThemes.resolve(AppThemeType.light),
      dark: AppThemes.resolve(AppThemeType.dark),
      mode: state.mode,
    );
  }

  /// 🧩 Fallback: default system mode
  static AppThemesScheme fallback() =>
      from(const ThemeModeAdapter(ThemeMode.system));

  //
}

/// 🎨 [AppThemesScheme] — Theme container passed into MaterialApp
/// ✅ Holds light/dark themes and current ThemeMode.

@immutable
final class AppThemesScheme {
  /// ─────-----------------

  final ThemeData light;
  final ThemeData dark;
  final ThemeMode mode;

  const AppThemesScheme({
    required this.light,
    required this.dark,
    required this.mode,
  });
}
