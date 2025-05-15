part of '_text_styles.dart';

/// 🧱 [TypographyFactory] — For single-use [TextStyle] creation on demand
/// 🧪 Optional: can be replaced by consistent use of [AppTextStyles]
//----------------------------------------------------------------

final class TypographyFactory {
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
