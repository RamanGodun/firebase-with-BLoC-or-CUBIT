import 'package:formz/formz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    return TextField(
      focusNode: focusNode,
      obscureText: true,
      autofillHints: null,
      // autofillHints: const [AutofillHints.newPassword],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'Confirm Password',
        prefixIcon: const Icon(Icons.lock_outline),
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}

enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');
  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
    : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.trim().isEmpty) return ConfirmPasswordValidationError.empty;
    if (value != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }

  /// ✅ Кастомний геттер, не override
  String? get errorText {
    if (isPure || isValid) return null;
    return switch (error) {
      ConfirmPasswordValidationError.empty => 'Confirmation required',
      ConfirmPasswordValidationError.mismatch => 'Passwords do not match',
      _ => null,
    };
  }

  /// ✅ Метод для оновлення пароля
  ConfirmPasswordInput updatePassword(String newPassword) =>
      ConfirmPasswordInput.dirty(password: newPassword, value: value);
}
