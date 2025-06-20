import 'package:flutter/material.dart';
import '../text_theme/text_theme_factory.dart';
import '../theme_styling/constants/app_colors.dart';
import '../theme_styling/constants/_app_constants.dart';

part 'theme_types_x.dart';

/// 🎨 [ThemeTypes] — Enhanced enum that defines full theme variants
/// ✅ Used to generate [ThemeData] dynamically

enum ThemeTypes {
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
    font: FontFamily.sfPro,
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
    font: FontFamily.sfPro,
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
    font: FontFamily.sfPro,
  );

  ////

  final Brightness brightness;
  final Color background;
  final Color primaryColor;
  final Color cardColor;
  final Color contrastColor;
  final ColorScheme colorScheme;
  final FontFamily font;

  const ThemeTypes({
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
  FontFamily get defaultFont => FontFamily.sfPro;

  //
}

////

////
