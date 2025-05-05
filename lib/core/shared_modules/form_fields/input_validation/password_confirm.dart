import 'package:formz/formz.dart' show FormzInput;

import '_enums.dart';

/// 🔐 [ConfirmPasswordInput] — Formz input that validates password confirmation.
/// Ensures the value is non-empty and matches the original password.
//-------------------------------------------------------------------------
class ConfirmPasswordInput
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

  String? get errorText => switch (error) {
    ConfirmPasswordValidationError.empty => 'Confirmation required',
    ConfirmPasswordValidationError.mismatch => 'Passwords do not match',
    _ => null,
  };

  String? get uiError => isPure || isValid ? null : errorText;

  ConfirmPasswordInput updatePassword(String newPassword) =>
      ConfirmPasswordInput.dirty(password: newPassword, value: value);

  List<Object?> get props => [value, error, password];
}
