import 'package:firebase_with_bloc_or_cubit/core/modules_shared/localization/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';
import '../../../core/modules_shared/theme/theme_styling/constants/_app_constants.dart';
import '../../../core/modules_shared/theme/theme_styling/constants/app_keys.dart';
import '../enums_for_form_fields_module.dart';
import 'app_text_field.dart';

/// 🏗️ Factory method that returns a themed [AppTextField], based on the [InputFieldType].
/// Ensures consistent look & feel across forms (SignUp/Login).

final class InputFieldFactory {
  //-------------------------
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

      //
    };
  }
}
