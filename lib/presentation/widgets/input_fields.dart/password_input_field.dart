import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///
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
      autofillHints: null,
      // autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
