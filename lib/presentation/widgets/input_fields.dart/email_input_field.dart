import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/constants/app_constants.dart' show AppConstants;
import '../../../core/constants/app_strings.dart' show AppStrings;

/// 📧 [EmailInputField] — textfield for email
class EmailInputField extends HookWidget {
  final FocusNode focusNode;
  final String? errorText;
  final void Function(String) onChanged;
  final VoidCallback? onSubmitted;

  const EmailInputField({
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
      key: const ValueKey('signup_email_field'),
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      // autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: AppStrings.email,
        prefixIcon: const Icon(AppConstants.emailIcon),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
