import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../presentation/constants/app_constants.dart' show AppConstants;
import '../../../presentation/constants/app_strings.dart' show AppStrings;

/// 👤 [NameInputField] input formfield for user name
class NameInputField extends HookWidget {
  final FocusNode focusNode;
  final String? errorText;
  final void Function(String) onChanged;
  final VoidCallback? onSubmitted;

  const NameInputField({
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
      key: const ValueKey('signup_name_field'),
      focusNode: focusNode,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      // autofillHints: const [AutofillHints.name],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: AppStrings.name,
        prefixIcon: const Icon(AppConstants.nameIcon),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
