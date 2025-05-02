import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'theme_enums.dart';

/// 🎨 [AppTextStyles] — Provides access to themed text styles
/// 🧼 Clean access: TextStyles4ThisAppThemes.getTheme(AppThemeMode.dark)
abstract class AppTextStyles {
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

/// 🏭 [TextStyleFactory] — Builds a full [TextTheme] from config
class TextStyleFactory {
  final Color color;
  const TextStyleFactory._(this.color);

  static const light = TextStyleFactory._(Colors.black);
  static const dark = TextStyleFactory._(Colors.white);

  TextTheme build([FontFamilyType? font]) {
    final family = (font ?? FontFamilyType.sfPro).value;
    return TextTheme(
      titleLarge: _style(FontWeight.w600, 22, family),
      titleMedium: _style(FontWeight.w500, 19, family),
      titleSmall: _style(FontWeight.w400, 16, family),
      bodyLarge: _style(FontWeight.w400, 17, family),
      bodyMedium: _style(FontWeight.w400, 15, family),
      bodySmall: _style(FontWeight.w400, 13, family),
      labelLarge: _style(FontWeight.w500, 15, family),
      labelMedium: _style(FontWeight.w400, 13, family),
      labelSmall: _style(FontWeight.w400, 11, family),
    );
  }

  TextStyle _style(FontWeight weight, double size, String family) => TextStyle(
    fontFamily: family,
    fontWeight: weight,
    fontSize: size,
    color: color,
  );
}

/// 🏭 [TypographyFactory] — Legacy access for single styles (optional override)
class TypographyFactory {
  static TextStyle get({
    required FontWeight weight,
    required double size,
    required Color color,
    FontFamilyType? font,
  }) {
    return TextStyle(
      fontFamily: (font ?? FontFamilyType.sfPro).value,
      fontWeight: weight,
      fontSize: size,
      color: color,
    );
  }
}
