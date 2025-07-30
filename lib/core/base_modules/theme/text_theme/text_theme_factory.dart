import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'font_family_enum.dart';

/// 🧩 [TextThemeFactory] — Entry point for accessing themed [TextTheme] & [CupertinoTextThemeData]
/// ✅ Centralized typography resolver used across both Material & Cupertino widgets
//
abstract final class TextThemeFactory {
  ///────────────────────────────

  /// 🎨 Builds TextTheme using color + optional font
  static TextTheme from(ColorScheme colorScheme, {AppFontFamily? font}) {
    //
    final color = colorScheme.onSurface;
    final fontFamily = (font ?? AppFontFamily.sfPro).value;

    return TextTheme(
      // DISPLAY
      displayLarge: _builder(color, FontWeight.w300, 57, fontFamily),
      displayMedium: _builder(color, FontWeight.w300, 45, fontFamily),
      displaySmall: _builder(color, FontWeight.w400, 36, fontFamily),

      // HEADLINE
      headlineLarge: _builder(color, FontWeight.w400, 32, fontFamily),
      headlineMedium: _builder(color, FontWeight.w400, 28, fontFamily),
      headlineSmall: _builder(color, FontWeight.w400, 24, fontFamily),

      // TITLE
      titleLarge: _builder(color, FontWeight.w500, 22, fontFamily),
      titleMedium: _builder(color, FontWeight.w500, 16, fontFamily),
      titleSmall: _builder(color, FontWeight.w500, 14, fontFamily),

      // BODY
      bodyLarge: _builder(color, FontWeight.w400, 16, fontFamily),
      bodyMedium: _builder(color, FontWeight.w400, 14, fontFamily),
      bodySmall: _builder(color, FontWeight.w400, 12, fontFamily),

      // LABEL
      labelLarge: _builder(color, FontWeight.w500, 14, fontFamily),
      labelMedium: _builder(color, FontWeight.w500, 12, fontFamily),
      labelSmall: _builder(color, FontWeight.w500, 11, fontFamily),
    );
  }

  /// 🧱  Builds individual [TextTheme]
  static TextStyle _builder(
    Color color,
    FontWeight weight,
    double size,
    String family,
  ) => TextStyle(
    fontFamily: family,
    fontWeight: weight,
    fontSize: size,
    color: color,
  );

  ////

  //
}
