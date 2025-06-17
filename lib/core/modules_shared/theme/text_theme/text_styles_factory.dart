part of '_text_styles.dart';

/// 🏭 [TextStyleFactory] — Generates complete [TextTheme] from [AppThemeMode] and optional font

final class TextStyleFactory {
  //-------------------------

  final Color color;
  const TextStyleFactory._(this.color);

  static const light = TextStyleFactory._(Colors.black);
  static const dark = TextStyleFactory._(Colors.white);

  /// 🎨 Builds [TextTheme] using provided font and base color
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

  /// 🧱 Builds individual [TextStyle]
  TextStyle _style(FontWeight weight, double size, String family) => TextStyle(
    fontFamily: family,
    fontWeight: weight,
    fontSize: size,
    color: color,
  );

  //
}
