import 'package:formz/formz.dart' show FormzInput;

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

  /// ✅
  String? get errorText {
    if (isPure || isValid) return null;
    return switch (error) {
      NameValidationError.empty => 'Name is required',
      NameValidationError.tooShort => 'Name must be at least 2 characters',
      _ => null,
    };
  }
}
