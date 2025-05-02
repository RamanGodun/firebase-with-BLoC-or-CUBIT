import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme_enums.dart';

/// 🎨 [TextStyles4ThisAppThemes] — Uses Enhanced Enum for ThemeMode
/// 🧼 Clean access: TextStyles4ThisAppThemes.getTheme(AppThemeMode.dark)
abstract class TextStyles4ThisAppThemes {
  static TextTheme getTheme(AppThemeMode mode, {FontFamilyType? font}) =>
      mode.builder.build(font);

  static CupertinoTextThemeData getCupertinoTextStyle(
    BuildContext context, {
    FontFamilyType font = FontFamilyType.sfPro,
  }) {
    return CupertinoTextThemeData(
      primaryColor: CupertinoColors.label,
      textStyle: TextStyle(
        fontFamily: font.value,
        fontSize: 17,
        fontWeight: FontWeight.w400,
        color: CupertinoColors.label,
      ),
    );
  }
}

/// 🏭 [TextStyleFactory] — Factory for TextTheme based on brightness
class TextStyleFactory {
  final Color color;
  const TextStyleFactory._(this.color);

  static const light = TextStyleFactory._(Colors.black);
  static const dark = TextStyleFactory._(Colors.white);

  TextTheme build([FontFamilyType? font]) {
    return TextTheme(
      titleLarge: _style(FontWeight.w600, 22, font),
      titleMedium: _style(FontWeight.w500, 19, font),
      titleSmall: _style(FontWeight.w400, 16, font),
      bodyLarge: _style(FontWeight.w400, 17, font),
      bodyMedium: _style(FontWeight.w400, 15, font),
      bodySmall: _style(FontWeight.w400, 13, font),
      labelLarge: _style(FontWeight.w500, 15, font),
      labelMedium: _style(FontWeight.w400, 13, font),
      labelSmall: _style(FontWeight.w400, 11, font),
    );
  }

  TextStyle _style(FontWeight weight, double size, FontFamilyType? font) {
    return TypographyFactory.get(
      weight: weight,
      size: size,
      color: color,
      font: font,
    );
  }
}

/// 🏭 [TypographyFactory] — returns single text style from params
class TypographyFactory {
  //
  static const _defaultFont = FontFamilyType.sfPro;

  static TextStyle get({
    required FontWeight weight,
    required double size,
    required Color color,
    FontFamilyType? font,
  }) {
    return TextStyle(
      fontFamily: (font ?? _defaultFont).value,
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }
}
