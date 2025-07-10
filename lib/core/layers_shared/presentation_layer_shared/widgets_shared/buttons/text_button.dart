import 'package:firebase_with_bloc_or_cubit/core/foundation/theme/extensions/theme_x.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../foundation/localization/widgets/text_widget.dart';

/// 🔘 [AppTextButton] — minimal, animated text-only button with underline option
class AppTextButton extends StatelessWidget {
  ///--------------------------------------

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool? isUnderlined;

  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.foregroundColor,
    this.fontSize = 15,
    this.fontWeight = FontWeight.w200,
    this.isUnderlined = true,
  });

  @override
  Widget build(BuildContext context) {
    //
    final colorScheme = context.colorScheme;
    final effectiveColor =
        (isEnabled && !isLoading)
            ? (foregroundColor ?? colorScheme.primary)
            : colorScheme.onSurface.withOpacity(0.4);

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: label,
      child: TextButton(
        onPressed: (isEnabled && !isLoading) ? onPressed : null,
        style: TextButton.styleFrom(
          foregroundColor: effectiveColor,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            layoutBuilder:
                (currentChild, previousChildren) => Stack(
                  alignment: Alignment.center,
                  children: [
                    if (currentChild != null) currentChild,
                    ...previousChildren,
                  ],
                ),
            transitionBuilder:
                (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
            child:
                isLoading
                    ? const CupertinoActivityIndicator(radius: 10)
                    : TextWidget(
                      label,
                      TextType.button,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      color: foregroundColor ?? colorScheme.primary,
                      isUnderlined: isUnderlined,
                    ),
          ),
        ),
      ),
    );
  }
}
