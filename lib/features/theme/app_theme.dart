import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import 'text_styles.dart';
import 'theme_enums.dart';

/// 🧩 Theme types
enum AppThemeVariant { light, dark, amoled, glass }

/// 🎨 [AppThemes] — Refactored with Abstract Factory pattern for clean, scalable theme generation
abstract class AppThemes {
  /// 🎯 Resolve full theme by variant
  static ThemeData resolve(AppThemeVariant variant, {FontFamilyType? font}) =>
      ThemeFactory(variant).build(font: font);

  /// 💡 Preview theme (e.g. for golden tests)
  static ThemeData preview({bool isDark = false}) =>
      ThemeFactory(
        isDark ? AppThemeVariant.dark : AppThemeVariant.light,
      ).build();
}

/// 🏭 [ThemeFactory] — Generates ThemeData using [AppThemeVariant] and optional [FontFamilyType]
class ThemeFactory {
  final AppThemeVariant variant;
  const ThemeFactory(this.variant);

  bool get isDark => switch (variant) {
    AppThemeVariant.dark => true,
    AppThemeVariant.amoled => true,
    AppThemeVariant.glass => true,
    AppThemeVariant.light => false,
  };

  ThemeData build({FontFamilyType? font}) {
    switch (variant) {
      case AppThemeVariant.light:
        return _baseTheme(
          Brightness.light,
          AppConstants.lightBackgroundColor,
          font: font,
        );

      case AppThemeVariant.dark:
        return _baseTheme(
          Brightness.dark,
          AppConstants.darkBackgroundColor,
          font: font,
        );

      case AppThemeVariant.amoled:
        return _baseTheme(Brightness.dark, Colors.black, font: font);

      case AppThemeVariant.glass:
        return _baseTheme(
          Brightness.dark,
          AppConstants.darkOverlay,
          font: font,
        ).copyWith(
          cardTheme: const CardTheme(
            color: Color(0xAA222222),
            shape: RoundedRectangleBorder(
              borderRadius: AppConstants.commonBorderRadius,
            ),
            elevation: 10,
          ),
        );
    }
  }

  ThemeData _baseTheme(
    Brightness brightness,
    Color background, {
    FontFamilyType? font,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: background,
      primaryColor: _primaryColor(isDark),
      colorScheme: _colorScheme(isDark),
      appBarTheme: _appBarTheme(isDark),
      elevatedButtonTheme: _elevatedButtonTheme(isDark),
      textTheme: TextStyles4ThisAppThemes.getTheme(
        isDark ? AppThemeMode.dark : AppThemeMode.light,
        font: font,
      ),
      cardTheme: _cardTheme(isDark),
    );
  }

  /// 🎨 Primary color resolution
  Color _primaryColor(bool isDark) =>
      isDark ? AppConstants.darkPrimaryColor : AppConstants.lightPrimaryColor;

  /// 🎨 ColorScheme factory
  ColorScheme _colorScheme(bool isDark) =>
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
          );

  /// 📌 AppBarTheme config
  AppBarTheme _appBarTheme(bool isDark) => AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: isDark ? Colors.white : Colors.black,
    actionsIconTheme: IconThemeData(color: _primaryColor(isDark)),
    titleTextStyle: TextStyle(
      fontFamily: 'SFProText',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: isDark ? Colors.white : Colors.black,
    ),
    centerTitle: false,
  );

  /// 🔘 ElevatedButtonTheme config
  ElevatedButtonThemeData _elevatedButtonTheme(bool isDark) =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor(isDark),
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: AppConstants.commonBorderRadius,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          elevation: 0.5,
        ),
      );

  /// 🟦 CardTheme config
  CardTheme _cardTheme(bool isDark) => CardTheme(
    color: isDark ? AppConstants.darkOverlay : AppConstants.lightOverlay,
    shape: const RoundedRectangleBorder(
      borderRadius: AppConstants.commonBorderRadius,
    ),
    shadowColor: Colors.black.withOpacity(isDark ? 0.2 : 0.1),
    elevation: 5,
  );
}
