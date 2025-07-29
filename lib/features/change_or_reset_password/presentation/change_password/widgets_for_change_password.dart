part of 'change_password_page.dart';

/// ℹ️ Info section for [ChangePasswordPage]
//
final class _ChangePasswordInfo extends StatelessWidget {
  ///-------------------------------------------------
  const _ChangePasswordInfo();

  @override
  Widget build(BuildContext context) {
    //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppSpacing.massive),
        const TextWidget(
          LocaleKeys.change_password_title,
          TextType.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xxxs),
        const TextWidget(
          LocaleKeys.change_password_warning,
          TextType.bodyMedium,
        ),
        Text.rich(
          TextSpan(
            text: LocaleKeys.change_password_prefix.tr(),
            style: const TextStyle(fontSize: 16),
            children: [
              TextSpan(
                text: LocaleKeys.change_password_signed_out.tr(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ).withPaddingOnly(top: AppSpacing.xxl, bottom: AppSpacing.xxxm);
  }
}

////

////

// /// 🧾 [_PasswordField] — input for the new password
// //
// final class _PasswordField extends StatelessWidget {
//   ///-------------------------------------------
//   //
//   final ({FocusNode password, FocusNode confirmPassword}) focus;
//   const _PasswordField({required this.focus});

//   @override
//   Widget build(BuildContext context) {
//     //
//     final form = ref.watch(changePasswordFormProvider);
//     final notifier = ref.read(changePasswordFormProvider.notifier);

//     return InputFieldFactory.create(
//       type: InputFieldType.password,
//       focusNode: focus.password,
//       errorText: form.password.uiErrorKey,
//       isObscure: form.isPasswordObscure,
//       onChanged: notifier.passwordChanged,
//       onSubmitted: () => focus.confirmPassword.requestFocus(),
//       suffixIcon: ObscureToggleIcon(
//         isObscure: form.isPasswordObscure,
//         onPressed: notifier.togglePasswordVisibility,
//       ),
//     ).withPaddingBottom(AppSpacing.m);
//   }
// }

// ////

// ////

// /// 🧾 [_ConfirmPasswordField] — confirmation input
// //
// final class _ConfirmPasswordField extends StatelessWidget {
//   ///---------------------------------------------------
//   // /
//   final ({FocusNode password, FocusNode confirmPassword}) focus;
//   const _ConfirmPasswordField({required this.focus});

//   @override
//   Widget build(BuildContext context) {
//     //
//     final form = ref.watch(changePasswordFormProvider);
//     final notifier = ref.read(changePasswordFormProvider.notifier);

//     return InputFieldFactory.create(
//       type: InputFieldType.confirmPassword,
//       focusNode: focus.confirmPassword,
//       errorText: form.confirmPassword.uiErrorKey,
//       isObscure: form.isConfirmPasswordObscure,
//       onChanged: notifier.confirmPasswordChanged,
//       onSubmitted: form.isValid ? () => ref.submitChangePassword() : null,
//       suffixIcon: ObscureToggleIcon(
//         isObscure: form.isConfirmPasswordObscure,
//         onPressed: notifier.toggleConfirmPasswordVisibility,
//       ),
//     ).withPaddingBottom(AppSpacing.xxxl);
//   }
// }

// ////

// ////

// /// 🔐 [_ChangePasswordSubmitButton] — dispatches the password change request
// /// 📤 Submits new password when form is valid
// //
// final class _ChangePasswordSubmitButton extends StatelessWidget {
//   ///--------------------------------------------------------
//   const _ChangePasswordSubmitButton();

//   @override
//   Widget build(BuildContext context) {
//     //
//     final form = ref.watch(changePasswordFormProvider);
//     final isOverlayActive = ref.isOverlayActive;
//     final isLoading = ref.watch(changePasswordProvider).isLoading;

//     return CustomFilledButton(
//       label:
//           isLoading
//               ? LocaleKeys.buttons_submitting
//               : LocaleKeys.change_password_title,
//       isLoading: isLoading,
//       isEnabled: form.isValid && !isOverlayActive,
//       onPressed:
//           form.isValid && !isLoading ? () => ref.submitChangePassword() : null,
//     );
//   }
// }
