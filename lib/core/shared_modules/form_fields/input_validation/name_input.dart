part of '_inputs_validation.dart';



/// 👤 [NameInputValidation] — Formz input for validating user's full name.
/// Ensures non-empty input and minimum character length.
//-------------------------------------------------------------------------

class NameInputValidation extends FormzInput<String, NameValidationError> {
  const NameInputValidation.pure() : super.pure('');
  const NameInputValidation.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return NameValidationError.empty;
    if (trimmed.length < 2) return NameValidationError.tooShort;
    return null;
  }

  /// 🧼 [errorText] — Converts enum error to user-friendly message
  String? get errorText => switch (error) {
    NameValidationError.empty => 'Name is required',
    NameValidationError.tooShort => 'Name must be at least 2 characters',
    _ => null,
  };

  /// 🔁 [uiError] — Used by widgets to show validation message or nothing
  String? get uiError => isPure || isValid ? null : errorText;
}
