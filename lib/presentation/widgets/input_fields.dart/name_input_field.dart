import 'package:formz/formz.dart';
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
    print(
      '📦 NameInputField built (focusNode.hasFocus: ${focusNode.hasFocus})',
    );

    ///
    return TextField(
      focusNode: focusNode,
      autofocus: true,
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

enum NameValidationError { empty, tooShort }

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    if (value.trim().isEmpty) return NameValidationError.empty;
    if (value.trim().length < 2) return NameValidationError.tooShort;
    return null;
  }

  /// ✅ Це кастомний геттер для UI, а не override
  String? get errorText {
    if (isPure || isValid) return null;
    return switch (error) {
      NameValidationError.empty => 'Name is required',
      NameValidationError.tooShort => 'Name must be at least 2 characters',
      _ => null,
    };
  }
}
