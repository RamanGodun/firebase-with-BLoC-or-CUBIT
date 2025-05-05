import 'package:flutter/material.dart';

import '../../../presentation/constants/_app_constants.dart';
import '../../../presentation/constants/app_strings.dart';
import 'app_text_field.dart';

/// 🔠 Supported input types
enum InputFieldType { name, email, password, confirmPassword }

/// 🏗️ Factory for creating consistent input fields across forms
class InputFieldFactory {
  static Widget create({
    required InputFieldType type,
    required FocusNode focusNode,
    required String? errorText,
    required void Function(String) onChanged,
    VoidCallback? onSubmitted,
  }) {
    return switch (type) {
      InputFieldType.name => AppTextField(
        key: const ValueKey('signup_name_field'),
        focusNode: focusNode,
        label: AppStrings.name,
        icon: AppIcons.name,
        obscure: false,
        errorText: errorText,
        keyboardType: TextInputType.name,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
      InputFieldType.email => AppTextField(
        key: const ValueKey('signup_email_field'),
        focusNode: focusNode,
        label: AppStrings.email,
        icon: AppIcons.email,
        obscure: false,
        errorText: errorText,
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
      InputFieldType.password => AppTextField(
        key: const ValueKey('signup_password_field'),
        focusNode: focusNode,
        label: AppStrings.password,
        icon: AppIcons.password,
        obscure: true,
        errorText: errorText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
      InputFieldType.confirmPassword => AppTextField(
        key: const ValueKey('signup_confirm_password_field'),
        focusNode: focusNode,
        label: AppStrings.confirmPassword,
        icon: AppIcons.confirmPassword,
        obscure: true,
        errorText: errorText,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    };
  }
}
