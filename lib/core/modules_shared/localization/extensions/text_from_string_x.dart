import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

/// 📜 Extension for fast TextWidget creation from string
extension TextWidgetFromSring on String {
  Widget styled(
    TextType type, {
    Color? color,
    TextAlign? align,
    FontWeight? weight,
    double? size,
    double? spacing,
    double? height,
    TextOverflow? overflow,
    int? maxLines,
    bool shadow = false,
    bool? multiline,
    bool? underline,
  }) {
    return TextWidget(
      this,
      type,
      color: color,
      alignment: align,
      fontWeight: weight,
      fontSize: size,
      letterSpacing: spacing,
      height: height,
      overflow: overflow,
      maxLines: maxLines,
      enableShadow: shadow,
      isTextOnFewStrings: multiline,
      isUnderlined: underline,
    );
  }
}
