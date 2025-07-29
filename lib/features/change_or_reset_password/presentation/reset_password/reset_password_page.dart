import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import '../../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/base_modules/localization/generated/locale_keys.g.dart';

part 'widgets_for_reset_password_page.dart';

/// 🔐 [ResetPasswordPage] — screen that allows user to request password reset
/// 📩 Sends reset link to user's email using [ResetPasswordProvider]
//
final class ResetPasswordPage extends StatelessWidget {
  ///------------------------------------------
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    // 👂 Declarative listener for success/failure
    // ref.listenToResetPassword(context);

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: ListView(
            shrinkWrap: true,
            children: const [
              //
              _ResetPasswordHeader(),

              // _ResetPasswordEmailInputField(),
              SizedBox(height: AppSpacing.huge),

              // _ResetPasswordSubmitButton(),
              SizedBox(height: AppSpacing.xxxs),

              // _ResetPasswordFooter(),
            ],
          ).withPaddingHorizontal(AppSpacing.l),
        ),
      ),
    );
  }
}

////

////

// /// 🛡️ [ResetPasswordRefX] — extension for WidgetRef to handle Reset Password side-effects.
// /// Handles submission and listens for result feedback (success/error).
// //
// extension ResetPasswordRefX on WidgetRef {
//   //
//   /// Encapsulates success and error handling for the reset password process.
//   ///   - ✅ On success: shows success snackbar and navigates to Sign In page.
//   ///   - ❌ On failure: shows localized error.
//   void listenToResetPassword(BuildContext context) {
//     final showSnackbar = context.showUserSnackbar;

//     listen<AsyncValue<void>>(resetPasswordProvider, (prev, next) {
//       next.whenOrNull(
//         // ✅ On success
//         data: (_) {
//           showSnackbar(message: LocaleKeys.reset_password_success.tr());
//           context.goIfMounted(RoutesNames.signIn);
//         },
//         // ❌ On error
//         error: (error, _) => context.showError((error as Failure).toUIEntity()),
//       );
//     });
//   }

//   ////

//   /// 📤 Submits the password reset request using the current form state.
//   void submitResetPassword() {
//     final form = read(resetPasswordFormProvider);
//     read(resetPasswordProvider.notifier).resetPassword(email: form.email.value);
//   }

//   //
// }
