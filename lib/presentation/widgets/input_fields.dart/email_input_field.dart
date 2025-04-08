import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///
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
    return TextField(
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      autofillHints: null,
      // autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
