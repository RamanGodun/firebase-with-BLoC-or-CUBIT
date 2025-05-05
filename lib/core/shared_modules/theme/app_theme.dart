import 'package:flutter/material.dart';

import '../../constants/_app_constants.dart';
import 'text_styles.dart';
import 'enums_for_theme.dart';

/// 🎨 [AppThemes] — Scalable theme generator for the app.
/// Supports variants via [AppThemeVariant] and dynamic font injection.
abstract class AppThemes {
  /// Returns theme based on [variant] and optional [font]
  static ThemeData resolve(AppThemeVariant variant, {FontFamilyType? font}) =>
      ThemeFactory(variant).build(font: font);

  /// Returns preview theme for light/dark switch
  static ThemeData preview({bool isDark = false}) =>
      ThemeFactory(
        isDark ? AppThemeVariant.dark : AppThemeVariant.light,
      ).build();
}

/// 🏭 [ThemeFactory] — Generates [ThemeData] from [AppThemeVariant]
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

  /// 📌 AppBar styling
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

  /// 🔘 ElevatedButton styling
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

  /// 🟦 Card styling
  CardTheme _buildCardTheme() => CardTheme(
    color: variant.cardColor,
    shape: const RoundedRectangleBorder(
      borderRadius: AppConstants.commonBorderRadius,
    ),
    shadowColor: AppColors.shadow,
    elevation: 5,
  );
}

/// 🧠 Maps semantic [TextStyleType] to corresponding style from [TextTheme]
TextStyle getSemanticStyle(TextTheme theme, TextStyleType type) =>
    switch (type) {
      TextStyleType.heading => theme.titleLarge!,
      TextStyleType.subheading => theme.titleMedium!,
      TextStyleType.body => theme.bodyLarge!,
      TextStyleType.label => theme.labelLarge!,
    };
