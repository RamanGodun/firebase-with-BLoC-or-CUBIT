import 'package:firebase_with_bloc_or_cubit/core/base_modules/animations/widget_animations/widget_animation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/theme/widgets_and_utils/extensions/theme_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x_barrel.dart';
import 'package:flutter/material.dart';
import '../../../base_modules/localization/module_widgets/text_widget.dart';
import '../../../base_modules/theme/ui_constants/_app_constants.dart';
import '../loader.dart';

/// 🧩 [CustomFilledButton] — Animated filled button with loader/text switch.
/// UI-only (no business logic), uses Hero for smooth transitions.
//
final class CustomFilledButton extends StatelessWidget {
  ///------------------------------------------
  //
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final bool? isValidated;

  const CustomFilledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.isValidated = true,
  });

  @override
  Widget build(BuildContext context) {
    //
    final colorScheme = context.colorScheme;

    return SizedBox(
      width: double.infinity,
      child: Hero(
        tag: 'filled_button',
        child: FilledButton(
          // 🚀 Only enabled when form is valid and not loading
          onPressed: isEnabled ? onPressed : null,

          // 🔁 Animated loader or text label
          child:
              (isLoading
                      ? AppLoader(
                        size: 20,
                        cupertinoRadius: 12,
                        color: colorScheme.onSurface,
                      )
                      : TextWidget(
                        label,
                        TextType.titleMedium,
                        fontWeight:
                            !isEnabled ? FontWeight.w300 : FontWeight.w400,
                        fontSize: 18,
                        letterSpacing: 0.9,
                        color:
                            (isLoading || !isEnabled)
                                ? colorScheme.inverseSurface
                                : colorScheme.onPrimary,
                      ))
                  .withAnimatedSwitcherSize(),
        ).withPaddingTop(AppSpacing.l),
      ),
    );
  }
}
