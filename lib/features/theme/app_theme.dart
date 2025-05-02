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
    final fontValue = (font ?? variant.font).value;

    return ThemeData(
      brightness: variant.brightness,
      scaffoldBackgroundColor: variant.background,
      primaryColor: variant.primaryColor,
      colorScheme: variant.colorScheme,
      appBarTheme: _buildAppBarTheme(fontValue),
      elevatedButtonTheme: _buildElevatedButtonTheme(),
      textTheme: AppTextStyles.getTheme(variant.appThemeMode, font: font),
      cardTheme: _buildCardTheme(),
    );
  }

  /// 📌 AppBarTheme config
  AppBarTheme _buildAppBarTheme(String fontFamily) => AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: variant.contrastColor,
    actionsIconTheme: IconThemeData(color: variant.primaryColor),
    titleTextStyle: TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: variant.contrastColor,
    ),
    centerTitle: false,
  );

  /// 🔘 ElevatedButtonTheme config
  ElevatedButtonThemeData _buildElevatedButtonTheme() =>
      ElevatedButtonThemeData(
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
  CardTheme _buildCardTheme() => CardTheme(
    color: variant.cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: AppConstants.commonBorderRadius,
    ),
    shadowColor: Colors.black.withOpacity(variant.isDark ? 0.2 : 0.1),
    elevation: 5,
  );
}

/// 📚 Semantic access to text styles
TextStyle getSemanticStyle(TextTheme theme, TextStyleType type) =>
    switch (type) {
      TextStyleType.heading => theme.titleLarge!,
      TextStyleType.subheading => theme.titleMedium!,
      TextStyleType.body => theme.bodyLarge!,
      TextStyleType.label => theme.labelLarge!,
    };
