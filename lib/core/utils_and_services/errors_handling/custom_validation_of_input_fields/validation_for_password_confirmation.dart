import 'package:formz/formz.dart' show FormzInput;

enum ConfirmPasswordValidationError { empty, mismatch }

class ConfirmPasswordInput
    extends FormzInput<String, ConfirmPasswordValidationError> {
  final String password;

  const ConfirmPasswordInput.pure({this.password = ''}) : super.pure('');
  const ConfirmPasswordInput.dirty({required this.password, String value = ''})
    : super.dirty(value);

  @override
  ConfirmPasswordValidationError? validator(String value) {
    if (value.trim().isEmpty) return ConfirmPasswordValidationError.empty;
    if (value != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }

  /// ✅
  String? get errorText {
    if (isPure || isValid) return null;
    return switch (error) {
      ConfirmPasswordValidationError.empty => 'Confirmation required',
      ConfirmPasswordValidationError.mismatch => 'Passwords do not match',
      _ => null,
    };
  }

  /// ✅
  ConfirmPasswordInput updatePassword(String newPassword) =>
      ConfirmPasswordInput.dirty(password: newPassword, value: value);
}
