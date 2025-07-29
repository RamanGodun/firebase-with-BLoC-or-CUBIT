part of 'validation_enums.dart';

/// 🔐 [ConfirmPasswordInputValidation] — Formz input that validates password confirmation.
/// Ensures the value is non-empty and matches the original password.

final class ConfirmPasswordInputValidation
    extends FormzInput<String, ConfirmPasswordValidationError> {
  ///------------------------------------------------------------------------

  final String password;

  const ConfirmPasswordInputValidation.pure({this.password = ''})
    : super.pure('');
  const ConfirmPasswordInputValidation.dirty({
    required this.password,
    String value = '',
  }) : super.dirty(value);

  ///
  @override
  ConfirmPasswordValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return ConfirmPasswordValidationError.empty;
    if (trimmed != password) return ConfirmPasswordValidationError.mismatch;
    return null;
  }

  /// 🧼 Converts enum to a localizable message key
  String? get errorKey => switch (error) {
    ConfirmPasswordValidationError.empty =>
      LocaleKeys.form_confirm_password_is_empty,
    ConfirmPasswordValidationError.mismatch =>
      LocaleKeys.form_confirm_password_mismatch,
    _ => null,
  };

  /// 🔁 [uiErrorKey] — Used by widgets to show validation message or nothing
  String? get uiErrorKey => isPure || isValid ? null : errorKey;

  /// 🧩 Create a copy with updated password reference
  ConfirmPasswordInputValidation updatePassword(String newPassword) =>
      ConfirmPasswordInputValidation.dirty(password: newPassword, value: value);

  //
}
