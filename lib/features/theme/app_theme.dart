import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import 'text_styles.dart';

/// 🎨 [AppThemes] — Refactored with Abstract Factory pattern for clean, scalable theme generation
abstract class AppThemes {
  static ThemeData getLightTheme() =>
      const _ThemeFactory(AppThemeMode.light).build();
  static ThemeData getDarkTheme() =>
      const _ThemeFactory(AppThemeMode.dark).build();
}

/// 🏭 [_ThemeFactory] — Generates ThemeData using [AppThemeMode]
class _ThemeFactory {
  final AppThemeMode mode;
  const _ThemeFactory(this.mode);

  bool get isDark => mode == AppThemeMode.dark;

  ThemeData build() {
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor:
          isDark
              ? AppConstants.darkBackgroundColor
              : AppConstants.lightBackgroundColor,

      /// 🎨 Color Scheme
      primaryColor:
          isDark
              ? AppConstants.darkPrimaryColor
              : AppConstants.lightPrimaryColor,
      colorScheme:
          isDark
              ? const ColorScheme.dark(
                primary: AppConstants.darkPrimaryColor,
                secondary: AppConstants.lightAccentColor,
                background: AppConstants.darkBackgroundColor,
                surface: AppConstants.darkSurface,
                onPrimary: Colors.white,
                onSecondary: Colors.white,
                onBackground: Colors.white,
                onSurface: Colors.white,
                error: AppConstants.errorColor,
              )
              : const ColorScheme.light(
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

      /// 📌 App Bar Theme
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? Colors.white : Colors.black,
        actionsIconTheme: IconThemeData(
          color:
              isDark
                  ? AppConstants.darkPrimaryColor
                  : AppConstants.lightPrimaryColor,
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'SFProText',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : Colors.black,
        ),
        centerTitle: false,
      ),

      /// 🔘 Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark
                  ? AppConstants.darkPrimaryColor
                  : AppConstants.lightPrimaryColor,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: AppConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0.5,
        ),
      ),

      /// 🖋 Text Theme
      textTheme: TextStyles4ThisAppThemes.getTheme(mode),

      /// 🟦 Card Theme (Glassmorphism style)
      cardTheme: CardTheme(
        color: isDark ? AppConstants.darkOverlay : AppConstants.lightOverlay,
        shape: const RoundedRectangleBorder(
          borderRadius: AppConstants.commonBorderRadius,
        ),
        shadowColor: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
        elevation: 5,
      ),
    );
  }
}
