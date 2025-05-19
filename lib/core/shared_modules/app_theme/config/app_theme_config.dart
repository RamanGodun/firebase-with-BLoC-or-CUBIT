import 'package:flutter/material.dart';
import '../../app_localization/when_no_localization/app_strings.dart';
import 'app_material_theme.dart';
import '../app_themes.dart';
import '../theme_cubit/theme_cubit.dart';
import '../theming_enums.dart';

/// 🎛️ [AppConfig] — Provides dynamic [AppThemeConfig] based on current state
/// ✅ Used to create `MaterialApp` config from [AppThemeState]
//-------------------------------------------------------------

@immutable
final class AppConfig {
  const AppConfig._();

  ///
  static AppThemeConfig fromState(AppThemeState state) {
    return AppThemeConfig(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.resolve(AppThemeType.light),
      darkTheme: AppThemes.resolve(AppThemeType.amoled),
      themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
    );
  }

  ///
}
