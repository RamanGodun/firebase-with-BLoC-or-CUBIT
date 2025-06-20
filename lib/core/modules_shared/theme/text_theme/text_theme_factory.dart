import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'font_family_enum.dart';

/// 🧩 [TextThemeFactory] — Entry point for accessing themed [TextTheme] & [CupertinoTextThemeData]
/// ✅ Centralized typography resolver used across both Material & Cupertino widgets

abstract final class TextThemeFactory {
  ///────────────────────────────

  /// 🎨 Builds TextTheme using color + optional font
  static TextTheme from(Color color, {FontFamily? font}) {
    //
    final fontFamily = (font ?? FontFamily.sfPro).value;

    return TextTheme(
      titleLarge: _builder(color, FontWeight.w600, 22, fontFamily),
      titleMedium: _builder(color, FontWeight.w500, 19, fontFamily),
      titleSmall: _builder(color, FontWeight.w400, 16, fontFamily),
      bodyLarge: _builder(color, FontWeight.w400, 17, fontFamily),
      bodyMedium: _builder(color, FontWeight.w400, 15, fontFamily),
      bodySmall: _builder(color, FontWeight.w400, 13, fontFamily),
      labelLarge: _builder(color, FontWeight.w500, 15, fontFamily),
      labelMedium: _builder(color, FontWeight.w400, 13, fontFamily),
      labelSmall: _builder(color, FontWeight.w400, 11, fontFamily),
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

  /// 🎨 From brightness shortcut
  static TextTheme fromBrightness(Brightness brightness, {FontFamily? font}) =>
      from(
        brightness == Brightness.dark ? Colors.white : Colors.black,
        font: font,
      );

  //
}
