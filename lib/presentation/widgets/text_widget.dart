import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

/// 📄 Flexible text widget with theme integration & extended customization.
class TextWidget extends StatelessWidget {
  final String? text;
  final TextType? textType;
  final Color? color;
  final TextAlign? alignment;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final double? height;
  final TextOverflow? overflow;
  final int? maxLines;
  final bool enableShadow;
  final bool? isTextOnFewStrings;
  final bool? isUnderlined;

  const TextWidget(
    this.text,
    this.textType, {
    super.key,
    this.color,
    this.alignment,
    this.fontWeight,
    this.fontSize,
    this.letterSpacing,
    this.height,
    this.overflow,
    this.maxLines,
    this.enableShadow = false,
    this.isTextOnFewStrings,
    this.isUnderlined,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    /// 🛠 Builds styled Text widget.
    Text buildText(TextStyle? baseStyle) {
      return Text(
        text ?? 'No text provided',
        textAlign: alignment ?? TextAlign.center,
        maxLines: isTextOnFewStrings == true ? null : maxLines,
        softWrap: isTextOnFewStrings == true ? true : null,
        overflow:
            isTextOnFewStrings == true
                ? TextOverflow.visible
                : (overflow ?? TextOverflow.ellipsis),
        style: baseStyle?.copyWith(
          color: color ?? Theme.of(context).colorScheme.onSurface,
          fontWeight: fontWeight ?? baseStyle.fontWeight,
          fontSize: fontSize ?? baseStyle.fontSize,
          letterSpacing: letterSpacing ?? baseStyle.letterSpacing,
          height: height ?? baseStyle.height,
          decoration: (isUnderlined == true) ? TextDecoration.underline : null,
          fontFamily: 'SFProText',
          shadows:
              enableShadow
                  ? [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(1, 1),
                    ),
                  ]
                  : null,
        ),
      );
    }

    /// 🎯 Select style based on [TextType].
    switch (textType) {
      case TextType.displayLarge:
        return buildText(textTheme.displayLarge);
      case TextType.displayMedium:
        return buildText(textTheme.displayMedium);
      case TextType.displaySmall:
        return buildText(textTheme.displaySmall);
      case TextType.headlineLarge:
        return buildText(textTheme.headlineLarge);
      case TextType.headlineMedium:
        return buildText(textTheme.headlineMedium);
      case TextType.headlineSmall:
        return buildText(textTheme.headlineSmall);
      case TextType.titleLarge:
        return buildText(textTheme.titleLarge);
      case TextType.titleMedium:
        return buildText(textTheme.titleMedium);
      case TextType.titleSmall:
        return buildText(textTheme.titleSmall);
      case TextType.bodyLarge:
        return buildText(textTheme.bodyLarge);
      case TextType.bodyMedium:
        return buildText(textTheme.bodyMedium);
      case TextType.bodySmall:
        return buildText(textTheme.bodySmall);
      case TextType.labelLarge:
        return buildText(textTheme.labelLarge);
      case TextType.labelMedium:
        return buildText(textTheme.labelMedium);
      case TextType.labelSmall:
        return buildText(textTheme.labelSmall);
      case TextType.button:
        return buildText(textTheme.labelLarge);
      case TextType.error:
        return buildText(
          textTheme.bodyLarge?.copyWith(color: AppConstants.errorColor),
        );
      case TextType.caption:
        return buildText(
          textTheme.bodySmall?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.grey.shade600,
          ),
        );
      default:
        return buildText(textTheme.bodyMedium);
    }
  }
}

/// 📑 Enum for text styles used in [TextWidget].
enum TextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
  button,
  error,
  caption,
}
