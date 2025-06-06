import 'package:firebase_with_bloc_or_cubit/core/shared_modules/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../core/shared_layers/shared_presentation/constants/_app_constants.dart';
import '../../../core/shared_layers/shared_presentation/constants/app_keys.dart';
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
final class InputFieldFactory {
  InputFieldFactory._();

  ///
  static Widget create({
    required InputFieldType type,
    required FocusNode focusNode,
    required String? errorText,
    required void Function(String) onChanged,
    bool isObscure = false,
    Widget? suffixIcon,
    VoidCallback? onSubmitted,
  }) {
    ///
    return switch (type) {
      ///
      InputFieldType.name => AppTextField(
        key: AppKeys.nameField,
        focusNode: focusNode,
        label: LocaleKeys.form_name,
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
        label: LocaleKeys.form_email,
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
        label: LocaleKeys.form_password,
        icon: AppIcons.password,
        obscure: isObscure,
        suffixIcon: suffixIcon,
        errorText: errorText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),

      ///
      InputFieldType.confirmPassword => AppTextField(
        key: AppKeys.confirmPasswordField,
        focusNode: focusNode,
        label: LocaleKeys.form_confirm_password,
        icon: AppIcons.confirmPassword,
        obscure: isObscure,
        suffixIcon: suffixIcon,
        errorText: errorText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),

      ///
    };
  }
}
