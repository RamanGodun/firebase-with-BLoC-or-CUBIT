import 'package:flutter/material.dart';
import '../../constants/app_strings.dart';
import '../../../features/theme/app_material_theme.dart';
import '../../../features/theme/app_theme.dart';
import '../../../features/theme/theme_cubit/theme_cubit.dart';
import '../../../features/theme/theme_enums.dart';

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
