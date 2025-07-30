import 'package:flutter/material.dart';
import '../../utils_shared/timing_control/timing_config.dart';
import 'text_theme/text_theme_factory.dart';
import 'ui_constants/_app_constants.dart';
import 'ui_constants/app_colors.dart';

part 'build_theme_x.dart';

/// 🎨 [ThemeVariantsEnum] — Enhanced enum that defines full theme variants
/// ✅ Used to generate [ThemeData] dynamically

enum ThemeVariantsEnum {
  //---------------

  light(
    brightness: Brightness.light,
    background: AppColors.lightBackground,
    primaryColor: AppColors.lightPrimary,
    cardColor: AppColors.lightOverlay,
    contrastColor: AppColors.black,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightAccent,
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
      onBackground: AppColors.black,
      onSurface: AppColors.black,
      error: AppColors.forErrors,
    ),
    font: AppFontFamily.sfPro,
  ),

  dark(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    primaryColor: AppColors.darkPrimary,
    cardColor: AppColors.darkGlassBackground,
    contrastColor: AppColors.white,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkAccent,
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onBackground: AppColors.white,
      onSurface: AppColors.white,
      error: AppColors.forErrors,
    ),
    font: AppFontFamily.sfPro,
  ),

  amoled(
    brightness: Brightness.dark,
    background: AppColors.black,
    primaryColor: AppColors.darkPrimary,
    cardColor: AppColors.darkGlassBackground,
    contrastColor: AppColors.white,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkAccent,
      background: AppColors.black,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onBackground: AppColors.white,
      onSurface: AppColors.white,
      error: AppColors.forErrors,
    ),
    font: AppFontFamily.sfPro,
  );

  ////

  final Brightness brightness;
  final Color background;
  final Color primaryColor;
  final Color cardColor;
  final Color contrastColor;
  final ColorScheme colorScheme;
  final AppFontFamily font;

  const ThemeVariantsEnum({
    required this.brightness,
    required this.background,
    required this.primaryColor,
    required this.cardColor,
    required this.contrastColor,
    required this.colorScheme,
    required this.font,
  });

  /// 🔘 True getter if dark theme
  bool get isDark => brightness == Brightness.dark;

  /// 🌓 Converts to [ThemeMode]
  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  /// 🔤 Selected font family
  AppFontFamily get defaultFont => AppFontFamily.sfPro;

  //
}

////

////
