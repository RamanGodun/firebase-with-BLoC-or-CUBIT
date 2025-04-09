import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/constants/app_constants.dart' show AppConstants;
import '../../../core/constants/app_strings.dart' show AppStrings;

/// ✅ [ConfirmPasswordInputField] — formfield for password confirmation
class ConfirmPasswordInputField extends HookWidget {
  final FocusNode focusNode;
  final String? errorText;
  final void Function(String) onChanged;
  final VoidCallback? onSubmitted;

  const ConfirmPasswordInputField({
    super.key,
    required this.focusNode,
    required this.errorText,
    required this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    ///
    return TextField(
      key: const ValueKey('signup_confirm_password_field'),
      focusNode: focusNode,
      obscureText: true,
      autofillHints: null,
      // autofillHints: const [AutofillHints.newPassword],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: AppStrings.confirmPassword,
        prefixIcon: const Icon(AppConstants.confirmPasswordIcon),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
