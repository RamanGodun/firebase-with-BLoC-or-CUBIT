/// 📧 [EmailValidationError] — Enum representing email-specific validation failures.
enum EmailValidationError {
  /// 🔠 Email is empty
  empty,

  /// ❌ Email format is invalid
  invalid,
}

/// 🧾 [NameValidationError] — Enum representing possible name input errors.
enum NameValidationError {
  // 🟥 Field is empty
  empty,
  // 🔡 Name is too short (less than 2 characters)
  tooShort,
}

/// 🔐 [PasswordValidationError] — Describes password validation issues.
enum PasswordValidationError {
  // 🟥 Field is empty
  empty,
  // 🔡 Less than 6 characters
  tooShort,
}

/// 🔒 [ConfirmPasswordValidationError] — Represents possible validation failures.
enum ConfirmPasswordValidationError {
  /// 🟥 Field is empty
  empty,

  /// 🔁 Passwords do not match
  mismatch,
}
