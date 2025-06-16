import '_inputs_validation.dart';

/// 🧠 [FormValidationService] — Handles input field validation logic.
/// ✅ Keeps Cubit clean (only state orchestration)
/// ✅ Centralizes and reuses validation logic across features

final class FormValidationService {
  const FormValidationService();

  /// 📧 Validates and returns updated [EmailInputValidation]
  EmailInputValidation validateEmail(String rawValue) {
    return EmailInputValidation.dirty(rawValue.trim());
  }

  /// 🔐 Validates and returns updated [PasswordInput]
  PasswordInput validatePassword(String rawValue) {
    return PasswordInput.dirty(rawValue.trim());
  }

  /// 👤 Validates and returns updated [NameInputValidation]
  NameInputValidation validateName(String rawValue) {
    return NameInputValidation.dirty(rawValue.trim());
  }

  /// 🔁 Validates and returns [ConfirmPasswordInput] based on [password]
  ConfirmPasswordInput validateConfirmPassword({
    required String password,
    required String value,
  }) {
    return ConfirmPasswordInput.dirty(password: password, value: value.trim());
  }

  /// 🔁 Syncs confirm password with updated [password]
  ConfirmPasswordInput syncConfirmWithPassword({
    required ConfirmPasswordInput currentConfirm,
    required String newPassword,
  }) {
    return currentConfirm.updatePassword(newPassword.trim());
  }

  //
}
