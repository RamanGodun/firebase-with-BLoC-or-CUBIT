import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';

part 'widgets_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — Screen that allows the user to update their password.
//
final class ChangePasswordPage extends HookWidget {
  ///-------------------------------------------
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    // 🔁 Declarative side-effect for ChangePassword
    // ref.listenToPasswordChange(context);

    // final focus = useChangePasswordFocusNodes();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: const [
                //
                _ChangePasswordInfo(),
                // _PasswordField(focus: focus),
                // _ConfirmPasswordField(focus: focus),
                // const _ChangePasswordSubmitButton(),
                //
              ],
            ).withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }

  //
}

////

////

// /// 🛡️ [PasswordChangeRefX] — handles side-effects for Change Password flow.
// //
// extension PasswordChangeRefX on WidgetRef {
//   ///---------------------------------------------
//   //
//   /// Encapsulates success, error, and retry handling.
//   ///   - ✅ On success: shows success snackbar and navigates home.
//   ///   - ❌ On failure: shows localized error.
//   ///   - 🔄 On "requires-recent-login" error: triggers reauthentication flow and retries on success.
//   void listenToPasswordChange(BuildContext context) {
//     listen<ChangePasswordState>(changePasswordProvider, (prev, next) async {
//       switch (next) {
//         ///
//         // ✅ On success
//         case ChangePasswordSuccess(:final message):
//           context.showUserSnackbar(message: message);
//           context.goIfMounted(RoutesNames.home);

//         /// 🔄 On reauth
//         case ChangePasswordRequiresReauth():
//           final result = await context.pushTo<String>(const SignInPage());
//           if (result == 'success') {
//             read(changePasswordProvider.notifier).retryAfterReauth();
//           }

//         /// ❌ On error
//         case ChangePasswordError(:final failure):
//           context.showError(failure.toUIEntity());
//         default:
//           break;
//       }
//     });
//   }

//   ////

//   /// 📤 Submits the password change request (when the form is valid)
//   Future<void> submitChangePassword() async {
//     final form = watch(changePasswordFormProvider);
//     if (!form.isValid) return;

//     final notifier = read(changePasswordProvider.notifier);
//     await notifier.changePassword(form.password.value);
//   }

//   //
// }
