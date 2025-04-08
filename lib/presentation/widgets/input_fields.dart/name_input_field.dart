import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
      // autofocus: true,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      autofillHints: null,
      // autofillHints: const [AutofillHints.name],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'Name',
        prefixIcon: const Icon(Icons.account_box),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
