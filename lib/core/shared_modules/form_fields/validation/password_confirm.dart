import 'package:formz/formz.dart' show FormzInput;

/// 🔒 [ConfirmPasswordValidationError] — validation rules
enum ConfirmPasswordValidationError { empty, mismatch }

/// 🔐 [ConfirmPasswordInput] — Confirms password match
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

  /// 🧠 User-friendly error string
  String? get errorText => switch (error) {
    ConfirmPasswordValidationError.empty => 'Confirmation required',
    ConfirmPasswordValidationError.mismatch => 'Passwords do not match',
    _ => null,
  };

  /// 🔁 Create a copy with updated password reference
  ConfirmPasswordInput updatePassword(String newPassword) =>
      ConfirmPasswordInput.dirty(password: newPassword, value: value);
}
