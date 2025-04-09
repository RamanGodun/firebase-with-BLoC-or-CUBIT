import 'package:formz/formz.dart' show FormzInput;

/// 🔒 Confirm password field validation errors
enum ConfirmPasswordValidationError { empty, mismatch }

/// *🧾[ConfirmPasswordInput] — Validates the confirm password field, validation logic:
///       - Must not be empty
///       - Must match the provided password

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  /// 🔹 Pure constructor (no value entered yet)
  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');

  /// 🔹 Dirty constructor (value has changed)
  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
    : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return ConfirmPasswordValidationError.empty;
    if (trimmed != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }

  /// 🧠 Converts enum error to user-friendly message
  String? get errorText {
    if (isPure || isValid) return null;
    return switch (error) {
      ConfirmPasswordValidationError.empty => 'Confirmation required',
      ConfirmPasswordValidationError.mismatch => 'Passwords do not match',
      _ => null,
    };
  }

  /// 🔁 Returns a new [ConfirmPasswordInput] with updated password reference
  ConfirmPasswordInput updatePassword(String newPassword) =>
      ConfirmPasswordInput.dirty(password: newPassword, value: value);
}
