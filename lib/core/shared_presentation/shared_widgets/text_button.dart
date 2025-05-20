import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../shared_modules/app_localization/code_base_for_both_options/text_widget.dart';

/// 🔁🌐 [RedirectTextButton] a reusable text button, used for navigation or redirects.
final class RedirectTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isDisabled;

  const RedirectTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            child: Divider(thickness: 0.5, color: AppColors.caption),
          ),
          const SizedBox(width: AppSpacing.m),
          TextWidget(
            label,
            TextType.bodyMedium,
            color: context.colorScheme.primary,
          ),
          const SizedBox(width: AppSpacing.m),
          const Expanded(
            child: Divider(thickness: 0.5, color: AppColors.caption),
          ),
        ],
      ),
    );
  }
}
