import 'package:firebase_with_bloc_or_cubit/core/foundation/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../theme/ui_constants/app_colors.dart';
import '../app_localizer.dart';

/// 📝 [TextWidget] — Custom Text widget with dynamic styling options.
/// Supports all native typography variants + additional decorations.

final class TextWidget extends StatelessWidget {
  ///------------------------------------------

  final String value;
  final TextType? textType;
  final String? fallback;
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
    this.value,
    this.textType, {
    super.key,
    this.fallback,
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

  ///

  @override
  Widget build(BuildContext context) {
    //
    final String text = _resolveText(value, fallback);
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
                    const Shadow(
                      blurRadius: 2.0,
                      color: AppColors.shadow,
                      offset: Offset(1, 1),
                    ),
                  ]
                  : null,
        ),
      );
    }

    /// 🌟 Map [TextType] to base styles from the current [TextTheme]
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
        return buildText(textTheme.titleSmall);
      case TextType.error:
        final errorStyle = textTheme.bodyLarge ?? const TextStyle();
        return buildText(errorStyle.copyWith(color: AppColors.forErrors));
      case TextType.caption:
        return buildText(
          textTheme.bodySmall?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.caption,
          ),
        );
      default:
        return buildText(textTheme.bodyMedium);
    }
  }

  /// Resolves [raw] as a localized key if possible.
  /// Returns translated text via [AppLocalizer] if initialized and key-like.
  /// Falls back to [fallback] or [raw] if translation is unavailable.
  String _resolveText(String raw, String? fallback) {
    final isLocalCaseKey = raw.contains('.');
    if (isLocalCaseKey && AppLocalizer.isInitialized) {
      return AppLocalizer.translateSafely(raw, fallback: fallback ?? raw);
    }
    return raw;
  }

  ///
}

////

////

/// 🧹 Enum for text style presets used by [TextWidget]
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
