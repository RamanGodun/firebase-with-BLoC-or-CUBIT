import 'package:formz/formz.dart' show FormzInput;

/// 🔠 Name field validation errors
enum NameValidationError { empty, tooShort }

/// * 🧾[NameInput] — Formz input for validating full name fields, validation logic:
///          - Must not be empty
///          - Must be at least 2 characters long

class NameInput extends FormzInput<String, NameValidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return NameValidationError.empty;
    if (trimmed.length < 2) return NameValidationError.tooShort;
    return null;
  }

  /// 🧠 Converts enum error to human-readable message for the UI.
  String? get errorText {
    if (isPure || isValid) return null;
    return switch (error) {
      NameValidationError.empty => 'Name is required',
      NameValidationError.tooShort => 'Name must be at least 2 characters',
      _ => null,
    };
  }
}
