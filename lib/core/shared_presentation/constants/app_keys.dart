import 'package:flutter/material.dart';

/// 🗝 [AppKeys] — All ValueKeys used across the app.
/// Centralized for testability, clarity, and consistency.
final class AppKeys {
  const AppKeys._();

  /// 👤 Signup fields
  static const nameField = ValueKey('signup_name_field');
  static const emailField = ValueKey('signup_email_field');
  static const passwordField = ValueKey('signup_password_field');
  static const confirmPasswordField = ValueKey('signup_confirm_password_field');

  // 🚀 Submit button
  static const submitButtonText = ValueKey('submit_button_text');
  static const submitButtonLoader = ValueKey('submit_button_loader');
}
