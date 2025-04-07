import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import 'text_styles.dart';

/// 🎨 **[AppThemes]** - Defines light and dark themes.
abstract class AppThemes {
  /// ☀️ **Light Theme**
  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppConstants.lightBackgroundColor,

      /// 🎨 **Color Scheme**
      primaryColor: AppConstants.lightPrimaryColor,
      colorScheme: const ColorScheme.light(
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

      /// 📌 **App Bar Theme**
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        actionsIconTheme: IconThemeData(color: AppConstants.lightPrimaryColor),
        titleTextStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        centerTitle: false,
      ),

      /// 🔘 **Elevated Button Theme**
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.lightPrimaryColor,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: AppConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0.5,
        ),
      ),

      /// 🖋 **Text Theme**
      textTheme: TextStyles4ThisAppThemes.kTextThemeData(false),

      /// 🟦 **Card Theme (For glassmorphism effect)**
      cardTheme: CardTheme(
        color: AppConstants.lightOverlay,
        shape: const RoundedRectangleBorder(
          borderRadius: AppConstants.commonBorderRadius,
        ),
        shadowColor: Colors.black.withOpacity(0.1),
        elevation: 5,
      ),
    );
  }

  // ================================================================= //

  /// 🌙 **Dark Theme**
  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppConstants.darkBackgroundColor,

      /// 🎨 **Color Scheme**
      primaryColor: AppConstants.darkPrimaryColor,
      colorScheme: const ColorScheme.dark(
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

      /// 📌 **App Bar Theme**
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        actionsIconTheme: IconThemeData(color: AppConstants.darkPrimaryColor),
        titleTextStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        centerTitle: false,
      ),

      /// 🔘 **Elevated Button Theme**
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.darkPrimaryColor,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: AppConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0.5,
        ),
      ),

      /// 🖋 **Text Theme**
      textTheme: TextStyles4ThisAppThemes.kTextThemeData(true),

      /// 🟦 **Card Theme (For glassmorphism effect)**
      cardTheme: CardTheme(
        color: AppConstants.darkOverlay,
        shape: const RoundedRectangleBorder(
          borderRadius: AppConstants.commonBorderRadius,
        ),
        shadowColor: Colors.black.withOpacity(0.2),
        elevation: 5,
      ),
    );
  }
}
