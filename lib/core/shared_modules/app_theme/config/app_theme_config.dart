import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../app_localization/generated/locale_keys.g.dart';
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
      title: LocaleKeys.app_title.tr(),
      debugShowCheckedModeBanner: false,
      theme: AppThemes.resolve(AppThemeType.light),
      darkTheme: AppThemes.resolve(AppThemeType.amoled),
      themeMode: state.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
    );
  }

  ///
}
