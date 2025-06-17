import 'package:flutter/material.dart';
import '../../text_theme/_text_styles.dart';
import '../app_colors.dart';

part 'font_family_type.dart';
part 'app_theme_mode.dart';

/// 🎨 [AppThemeType] — Enhanced enum that defines full theme variants
/// ✅ Used to generate [ThemeData] dynamically

enum AppThemeType {
  //---------------

  ///
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
  ),

  ///
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
  ),

  ///
  amoled(
    brightness: Brightness.dark,
    background: AppColors.black,
    primaryColor: AppColors.darkPrimary,
    cardColor: AppColors.darkOverlay,
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
  ),

  ///
  glass(
    brightness: Brightness.dark,
    background: AppColors.darkOverlay,
    primaryColor: AppColors.darkPrimary,
    cardColor: AppColors.glassCard,
    contrastColor: AppColors.white,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkAccent,
      background: AppColors.darkOverlay,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onBackground: AppColors.white,
      onSurface: AppColors.white,
      error: AppColors.forErrors,
    ),

    //
  );

  ///

  const AppThemeType({
    required this.brightness,
    required this.background,
    required this.primaryColor,
    required this.cardColor,
    required this.contrastColor,
    required this.colorScheme,
  });

  final Brightness brightness;
  final Color background;
  final Color primaryColor;
  final Color cardColor;
  final Color contrastColor;
  final ColorScheme colorScheme;

  /// 🔘 True getter if dark theme
  bool get isDark => brightness == Brightness.dark;

  /// 📦 Converts to [ThemeMode]
  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;

  /// 🌓 Maps to [AppThemeMode]
  AppThemeMode get appThemeMode =>
      isDark ? AppThemeMode.dark : AppThemeMode.light;

  /// 🔤 Selected font family
  FontFamilyType get font => FontFamilyType.sfPro;

  //
}
