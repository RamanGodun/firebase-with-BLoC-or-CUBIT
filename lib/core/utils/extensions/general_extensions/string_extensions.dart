part of '_general_extensions.dart';

// extension StringX on String {
//   String capitalize() =>
//       isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
// }

extension TextTypeX on String {
  Widget styledWith(
    TextType type, {
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    double? letterSpacing,
    double? lineHeight,
    TextOverflow? overflow,
    int? maxLines,
    bool enableShadow = false,
    bool? multiline,
    bool? underline,
  }) {
    return TextWidget(
      this,
      type,
      color: color,
      alignment: textAlign,
      fontWeight: fontWeight,
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      height: lineHeight,
      overflow: overflow,
      maxLines: maxLines,
      enableShadow: enableShadow,
      isTextOnFewStrings: multiline,
      isUnderlined: underline,
    );
  }
}
