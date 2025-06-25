import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'font_family_enum.dart';

/// 🧩 [TextThemeFactory] — Entry point for accessing themed [TextTheme] & [CupertinoTextThemeData]
/// ✅ Centralized typography resolver used across both Material & Cupertino widgets

abstract final class TextThemeFactory {
  ///────────────────────────────

  /// 🎨 Builds TextTheme using color + optional font
  static TextTheme from(ColorScheme colorScheme, {AppFontFamily? font}) {
    //
    final color = colorScheme.onSurface;
    final fontFamily = (font ?? AppFontFamily.sfPro).value;

    return TextTheme(
      titleLarge: _builder(color, FontWeight.w500, 22, fontFamily),
      titleMedium: _builder(color, FontWeight.w400, 16, fontFamily),
      titleSmall: _builder(color, FontWeight.w300, 16, fontFamily),
      bodyLarge: _builder(color, FontWeight.w400, 15, fontFamily),
      bodyMedium: _builder(color, FontWeight.w300, 14, fontFamily),
      bodySmall: _builder(color, FontWeight.w400, 12, fontFamily),
      labelLarge: _builder(color, FontWeight.w300, 16, fontFamily),
      labelMedium: _builder(color, FontWeight.w300, 14, fontFamily),
      labelSmall: _builder(color, FontWeight.w400, 12, fontFamily),
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
