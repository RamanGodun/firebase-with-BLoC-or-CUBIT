import 'package:flutter/material.dart';
import '../../../constants/_app_constants.dart';
import '../../../constants/app_strings.dart';
import '../app_keys.dart';
import 'app_text_field.dart';

/// 🔠 Supported input types for signup & login forms
enum InputFieldType {
  // 👤 User's display name. Used for user registration.
  name,
  // 📧 Email address. Used for login and registration.
  email,
  // 🔒 Account password. Used in login, signup, and change-password.
  password,
  // 🔒🔁 Password confirmation. Used in signup and password reset.
  confirmPassword,
}

//---------------------------------------------------------------------------------------

/// 🏗️ Factory method that returns a themed [AppTextField], based on the [InputFieldType].
/// Ensures consistent look & feel across forms (SignUp/Login).
abstract class InputFieldFactory {
  static Widget create({
    required InputFieldType type,
    required FocusNode focusNode,
    required String? errorText,
    required void Function(String) onChanged,
    VoidCallback? onSubmitted,
    bool isObscure = false,
    Widget? suffixIcon,

    ///
  }) {
    ///
    return switch (type) {
      ///
      InputFieldType.name => AppTextField(
        key: AppKeys.nameField,
        focusNode: focusNode,
        label: AppStrings.name,
        icon: AppIcons.name,
        obscure: false,
        errorText: errorText,
        keyboardType: TextInputType.name,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),

      ///
      InputFieldType.email => AppTextField(
        key: AppKeys.emailField,
        focusNode: focusNode,
        label: AppStrings.email,
        icon: AppIcons.email,
        obscure: false,
        errorText: errorText,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),

      ///
      InputFieldType.password => AppTextField(
        key: AppKeys.passwordField,
        focusNode: focusNode,
        label: AppStrings.password,
        icon: AppIcons.password,
        suffixIcon: suffixIcon,
        obscure: isObscure,
        errorText: errorText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),

      ///
      InputFieldType.confirmPassword => AppTextField(
        key: AppKeys.confirmPasswordField,
        focusNode: focusNode,
        label: AppStrings.confirmPassword,
        icon: AppIcons.confirmPassword,
        suffixIcon: suffixIcon,
        obscure: isObscure,
        errorText: errorText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),

      ///
    };
  }
}
