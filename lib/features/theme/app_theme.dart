import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import 'text_styles.dart';
import 'theme_enums.dart';

/// 🎨 [AppThemes] — clean, scalable theme factory
abstract class AppThemes {
  static ThemeData resolve(AppThemeVariant variant, {FontFamilyType? font}) =>
      ThemeFactory(variant).build(font: font);

  static ThemeData preview({bool isDark = false}) =>
      ThemeFactory(
        isDark ? AppThemeVariant.dark : AppThemeVariant.light,
      ).build();
}

/// 🏭 [ThemeFactory] — Generates ThemeData using enhanced AppThemeVariant
class ThemeFactory {
  final AppThemeVariant variant;
  const ThemeFactory(this.variant);

  ThemeData build({FontFamilyType? font}) {
    return ThemeData(
      brightness: variant.brightness,
      scaffoldBackgroundColor: variant.background,
      primaryColor: variant.primaryColor,
      colorScheme: variant.colorScheme,
      appBarTheme: _appBarTheme(font),
      elevatedButtonTheme: _elevatedButtonTheme(),
      textTheme: TextStyles4ThisAppThemes.getTheme(
        variant.isDark ? AppThemeMode.dark : AppThemeMode.light,
        font: font,
      ),
      cardTheme: _cardTheme(),
    );
  }

  /// 📌 AppBarTheme config
  AppBarTheme _appBarTheme(FontFamilyType? font) => AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: variant.isDark ? Colors.white : Colors.black,
    actionsIconTheme: IconThemeData(color: variant.primaryColor),
    titleTextStyle: TextStyle(
      fontFamily: (font ?? FontFamilyType.sfPro).value,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: variant.isDark ? Colors.white : Colors.black,
    ),
    centerTitle: false,
  );

  /// 🔘 ElevatedButtonTheme config
  ElevatedButtonThemeData _elevatedButtonTheme() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: variant.primaryColor,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: AppConstants.commonBorderRadius,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      elevation: 0.5,
    ),
  );

  /// 🟦 CardTheme config
  CardTheme _cardTheme() => CardTheme(
    color: variant.cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: AppConstants.commonBorderRadius,
    ),
    shadowColor: Colors.black.withOpacity(variant.isDark ? 0.2 : 0.1),
    elevation: 5,
  );
}

TextStyle getSemanticStyle(TextTheme theme, TextStyleType type) =>
    switch (type) {
      TextStyleType.heading => theme.titleLarge!,
      TextStyleType.subheading => theme.titleMedium!,
      TextStyleType.body => theme.bodyLarge!,
      TextStyleType.label => theme.labelLarge!,
    };
