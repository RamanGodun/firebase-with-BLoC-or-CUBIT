part of '../enums_for_form_fields_module.dart';

/// 📧 [EmailInputValidation] — Formz input for validating user email.
/// Checks for non-empty input and valid email format.

final class EmailInputValidation
    extends FormzInput<String, EmailValidationError> {
  //-------------------------------------------------

  const EmailInputValidation.pure() : super.pure('');
  const EmailInputValidation.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return EmailValidationError.empty;
    if (!isEmail(trimmed)) return EmailValidationError.invalid;
    return null;
  }

  /// 🧼 [errorText] — Converts enum error to a human-readable message
  String? get errorText => switch (error) {
    EmailValidationError.empty => 'Email is required',
    EmailValidationError.invalid => 'Invalid email address',
    _ => null,
  };

  /// 🔁 [uiError] — Used by widgets to show validation message or nothing
  String? get uiError => isPure || isValid ? null : errorText;

  //
}
