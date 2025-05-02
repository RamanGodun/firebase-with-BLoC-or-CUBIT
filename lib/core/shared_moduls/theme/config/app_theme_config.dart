import 'package:flutter/material.dart';
import '../../../presentation/constants/app_strings.dart';
import 'app_material_theme.dart';
import '../app_theme.dart';
import '../theme_cubit/theme_cubit.dart';
import '../enums_for_theme.dart';

/// 🎛️ [AppConfig] — Isolated configuration class for theme composition
abstract class AppConfig {
  ///
  static AppThemeConfig fromState(AppThemeState state) {
    return AppThemeConfig(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.resolve(AppThemeVariant.light),
      darkTheme: AppThemes.resolve(AppThemeVariant.amoled),
      themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
