import 'package:flutter/material.dart';
import '../../features/domain/constants/app_constants.dart';
import '../../core/utils_and_services/extensions/context_extensions/_context_extensions.dart';

/// 📝 [TextWidget] — Custom Text widget with dynamic styling options.
/// Supports all native typography variants + additional decorations.
class TextWidget extends StatelessWidget {
  ///
  final String text;
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
    final textTheme = context.textTheme;
    final colorScheme = context.colorScheme;
    final isMultiLine = isTextOnFewStrings ?? false;
    final overflowMode =
        isMultiLine
            ? TextOverflow.visible
            : (overflow ?? TextOverflow.ellipsis);

    /// 🛠️ Builds the styled [Text] widget based on provided [TextStyle].
    Text buildText(TextStyle? baseStyle) {
      final effectiveStyle = baseStyle ?? const TextStyle();

      return Text(
        text,
        textAlign: alignment ?? TextAlign.center,
        maxLines: isMultiLine ? null : maxLines,
        softWrap: isMultiLine,
        overflow: overflowMode,
        style: effectiveStyle.copyWith(
          color: color ?? colorScheme.onSurface,
          fontWeight: fontWeight ?? effectiveStyle.fontWeight,
          fontSize: fontSize ?? effectiveStyle.fontSize,
          letterSpacing: letterSpacing ?? effectiveStyle.letterSpacing,
          height: height ?? effectiveStyle.height,
          // fontFamily: 'SFProText',
          decoration: switch (isUnderlined) {
            true => TextDecoration.underline,
            false => TextDecoration.none,
            null => null,
          },
          decorationColor: color ?? colorScheme.onSurface,
          decorationThickness: 0.4,
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

    /// 🎯 Map [TextType] to base styles from the current [TextTheme]
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
        final errorStyle = textTheme.bodyLarge ?? const TextStyle();
        return buildText(errorStyle.copyWith(color: AppConstants.errorColor));
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

/// 🧩 Enum for text style presets used by [TextWidget]
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
