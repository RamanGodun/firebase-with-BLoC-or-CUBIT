part of '_validation_enums.dart';

/// 🔒 [PasswordInput] — Validates presence and minimum password length.

final class PasswordInput extends FormzInput<String, PasswordValidationError> {
  ///------------------------------------------------------------------------

  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  ///
  @override
  PasswordValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return PasswordValidationError.empty;
    if (trimmed.length < 6) return PasswordValidationError.tooShort;
    return null;
  }

  /// 🧼 Converts enum to readable message
  String? get errorText => switch (error) {
    PasswordValidationError.empty => 'Password is required',
    PasswordValidationError.tooShort =>
      'Password must be at least 6 characters',
    _ => null,
  };

  /// 🔁 Used by widgets to show message only when needed
  String? get uiError => isPure || isValid ? null : errorText;

  //
}
