// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import '../../presentation/constants/app_constants.dart';
import 'text_styles.dart';

/// 🧩 Theme types — Enhanced Enum with behavior
enum AppThemeVariant {
  light(
    brightness: Brightness.light,
    background: AppConstants.lightBackgroundColor,
    primaryColor: AppConstants.lightPrimaryColor,
    cardColor: AppConstants.lightOverlay,
    contrastColor: Colors.black,
    colorScheme: ColorScheme.light(
      primary: AppConstants.lightPrimaryColor,
      secondary: AppConstants.lightAccentColor,
      background: AppConstants.lightBackgroundColor,
      surface: AppConstants.lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
      error: AppConstants.errorColor,
    ),
  ),
  dark(
    brightness: Brightness.dark,
    background: AppConstants.darkBackgroundColor,
    primaryColor: AppConstants.darkPrimaryColor,
    cardColor: AppConstants.darkOverlay,
    contrastColor: Colors.white,
    colorScheme: ColorScheme.dark(
      primary: AppConstants.darkPrimaryColor,
      secondary: AppConstants.lightAccentColor,
      background: AppConstants.darkBackgroundColor,
      surface: AppConstants.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: AppConstants.errorColor,
    ),
  ),
  amoled(
    brightness: Brightness.dark,
    background: Colors.black,
    primaryColor: AppConstants.darkPrimaryColor,
    cardColor: AppConstants.darkOverlay,
    contrastColor: Colors.white,
    colorScheme: ColorScheme.dark(
      primary: AppConstants.darkPrimaryColor,
      secondary: AppConstants.lightAccentColor,
      background: Colors.black,
      surface: AppConstants.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: AppConstants.errorColor,
    ),
  ),
  glass(
    brightness: Brightness.dark,
    background: AppConstants.darkOverlay,
    primaryColor: AppConstants.darkPrimaryColor,
    cardColor: Color(0xAA222222),
    contrastColor: Colors.white,
    colorScheme: ColorScheme.dark(
      primary: AppConstants.darkPrimaryColor,
      secondary: AppConstants.lightAccentColor,
      background: AppConstants.darkOverlay,
      surface: AppConstants.darkSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      error: AppConstants.errorColor,
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
