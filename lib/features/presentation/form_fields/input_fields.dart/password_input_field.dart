import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../domain/constants/app_constants.dart' show AppConstants;
import '../../../domain/constants/app_strings.dart' show AppStrings;

/// 🔐 [PasswordInputField] — formfield for password input
class PasswordInputField extends HookWidget {
  final FocusNode focusNode;
  final String? errorText;
  final void Function(String) onChanged;
  final VoidCallback? onSubmitted;

  const PasswordInputField({
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
      key: const ValueKey('signup_password_field'),
      focusNode: focusNode,
      obscureText: true,
      // autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: AppStrings.password,
        prefixIcon: const Icon(AppConstants.passwordIcon),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
