import 'package:formz/formz.dart' show FormzInput;

/// 🔠 Validation errors for [NameInput]
enum NameValidationError { empty, tooShort }

/// 👤 [NameInput] — Validates full name for presence and length
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

  /// 🧠 Converts enum to string message
  String? get errorText => switch (error) {
    NameValidationError.empty => 'Name is required',
    NameValidationError.tooShort => 'Name must be at least 2 characters',
    _ => null,
  };
}
