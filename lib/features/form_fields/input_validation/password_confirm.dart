part of '_inputs_validation.dart';

/// 🔐 [ConfirmPasswordInput] — Formz input that validates password confirmation.
/// Ensures the value is non-empty and matches the original password.
//-------------------------------------------------------------------------

final class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');
  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
    : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return ConfirmPasswordValidationError.empty;
    if (trimmed != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }

  /// 🧼 Converts enum error to a user-friendly message
  String? get errorText => switch (error) {
    ConfirmPasswordValidationError.empty => 'Confirmation required',
    ConfirmPasswordValidationError.mismatch => 'Passwords do not match',
    _ => null,
  };

  /// 🔁 Used by widgets to show validation message or nothing
  String? get uiError => isPure || isValid ? null : errorText;

  /// 🧩 Create a copy with updated password reference
  ConfirmPasswordInput updatePassword(String newPassword) =>
      ConfirmPasswordInput.dirty(password: newPassword, value: value);
}
