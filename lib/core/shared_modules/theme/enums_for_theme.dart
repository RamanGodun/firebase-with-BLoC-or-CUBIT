import 'package:flutter/material.dart';
import '../../constants/_app_constants.dart';
import 'text_styles.dart';

/// 🧩 Theme types — Enhanced Enum with behavior
enum AppThemeVariant {
  light(
    brightness: Brightness.light,
    background: AppColors.lightBackground,
    primaryColor: AppColors.lightPrimary,
    cardColor: AppColors.lightOverlay,
    contrastColor: Colors.black,
    colorScheme: ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightAccent,
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
      error: AppColors.forErrors,
    ),
  ),
  dark(
    brightness: Brightness.dark,
    background: AppColors.darkBackground,
    primaryColor: AppColors.darkPrimary,
    cardColor: AppColors.darkOverlay,
    contrastColor: Colors.white,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.lightAccent,
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: AppColors.forErrors,
    ),
  ),
  amoled(
    brightness: Brightness.dark,
    background: Colors.black,
    primaryColor: AppColors.darkPrimary,
    cardColor: AppColors.darkOverlay,
    contrastColor: Colors.white,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.lightAccent,
      background: Colors.black,
      surface: AppColors.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: AppColors.forErrors,
    ),
  ),
  glass(
    brightness: Brightness.dark,
    background: AppColors.darkOverlay,
    primaryColor: AppColors.darkPrimary,
    cardColor: Color(0xAA222222),
    contrastColor: Colors.white,
    colorScheme: ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.lightAccent,
      background: AppColors.darkOverlay,
      surface: AppColors.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: AppColors.forErrors,
    ),
  );

  const AppThemeVariant({
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

  bool get isDark => brightness == Brightness.dark;
  ThemeMode get themeMode => isDark ? ThemeMode.dark : ThemeMode.light;
  AppThemeMode get appThemeMode =>
      isDark ? AppThemeMode.dark : AppThemeMode.light;
  FontFamilyType get font => FontFamilyType.sfPro;
}

/// ✨ Enhanced enum for font family options
enum FontFamilyType {
  sfPro('SFProText'),
  aeonik('Aeonik'),
  poppins('Poppins');
  // google => custom dynamic font loading could go here later

  final String value;
  const FontFamilyType(this.value);

  bool get isGoogle => this == FontFamilyType.poppins;
}

/// 🌗 [AppThemeMode] — Enhanced enum to select between dark/light theme
enum AppThemeMode {
  light(TextStyleFactory.light),
  dark(TextStyleFactory.dark);

  final TextStyleFactory builder;
  const AppThemeMode(this.builder);
}

/// 📚 Semantic text styles for better DX/UI logic
enum TextStyleType { heading, subheading, body, label }

TextStyle getSemanticStyle(TextTheme theme, TextStyleType type) =>
    switch (type) {
      TextStyleType.heading => theme.titleLarge!,
      TextStyleType.subheading => theme.titleMedium!,
      TextStyleType.body => theme.bodyLarge!,
      TextStyleType.label => theme.labelLarge!,
    };
