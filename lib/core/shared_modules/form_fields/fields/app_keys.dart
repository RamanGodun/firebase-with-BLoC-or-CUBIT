import 'package:flutter/material.dart';

/// 🗝 [AppKeys] — keys used for testing and identifying UI widgets in forms.
/// Useful in widget tests and key-based lookups (e.g., finding fields).
abstract class AppKeys {
  // 👤 Signup fields
  static const nameField = ValueKey('signup_name_field');
  static const emailField = ValueKey('signup_email_field');
  static const passwordField = ValueKey('signup_password_field');
  static const confirmPasswordField = ValueKey('signup_confirm_password_field');
}
