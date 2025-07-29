import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/form_fields/input_validation/formz_status_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_overlay_base_methods.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../app_bootstrap_and_config/di_container/di_container.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/utils/_form_validation_service.dart';
import '../../../../core/base_modules/form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/base_modules/form_fields/widgets/password_visibility_icon.dart';
import '../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/base_modules/localization/widgets/text_widget.dart';
import '../../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/form_submit_button.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import '../../domain/password_actions_use_case.dart';
import 'cubit/change_password_cubit.dart';

part 'widgets_for_change_password.dart';

/// 🔐 [ChangePasswordPage] — allows user to request password change
/// 🔁 Declarative side-effect for [ResetPasswordPage]
//
final class ChangePasswordPage extends StatelessWidget {
  ///---------------------------------------
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      create:
          (_) => ChangePasswordCubit(
            di<PasswordRelatedUseCases>(),
            di<FormValidationService>(),
          ),
      child: MultiBlocListener(
        listeners: [
          /// ❌ Error Listener
          BlocListener<ChangePasswordCubit, ChangePasswordState>(
            listenWhen:
                (prev, curr) =>
                    prev.status != curr.status &&
                    curr.status.isSubmissionFailure,
            listener: (context, state) {
              final error = state.failure?.consume();
              if (error != null) {
                context.showError(error.toUIEntity());
                context.read<ChangePasswordCubit>().clearFailure();
              }
            },
          ),

          /// ✅ Success Listener
          BlocListener<ChangePasswordCubit, ChangePasswordState>(
            listenWhen:
                (prev, curr) =>
                    prev.status != curr.status &&
                    curr.status.isSubmissionSuccess,
            listener: (context, state) {
              context.showSnackbar(message: LocaleKeys.change_password_success);
              // 🧭 Navigation after success
              context.goTo(RoutesNames.home);
            },
          ),
        ],

        child: const _ChangePasswordView(),
      ),
    );
  }
}

/// 🔐 [_ChangePasswordView] — Screen that allows the user to update their password.
//
final class _ChangePasswordView extends HookWidget {
  ///-------------------------------------------
  const _ChangePasswordView();

  @override
  Widget build(BuildContext context) {
    //
    final focus = useChangePasswordFocusNodes();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                //
                const _ChangePasswordInfo(),
                _PasswordField(focusNodes: focus),
                _ConfirmPasswordField(focusNodes: focus),
                const _ChangePasswordSubmitButton(),
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
/*



/// 🛡️ [PasswordChangeRefX] — handles side-effects for Change Password flow.
//
extension PasswordChangeRefX on WidgetRef {
  ///---------------------------------------------
  //
  /// Encapsulates success, error, and retry handling.
  ///   - ✅ On success: shows success snackbar and navigates home.
  ///   - ❌ On failure: shows localized error.
  ///   - 🔄 On "requires-recent-login" error: triggers reauthentication flow and retries on success.
  void listenToPasswordChange(BuildContext context) {
    listen<ChangePasswordState>(changePasswordProvider, (prev, next) async {
      switch (next) {
        ///
        // ✅ On success
        case ChangePasswordSuccess(:final message):
          context.showUserSnackbar(message: message);
          context.goIfMounted(RoutesNames.home);

        /// 🔄 On reauth
        case ChangePasswordRequiresReauth():
          final result = await context.pushTo<String>(const SignInPage());
          if (result == 'success') {
            read(changePasswordProvider.notifier).retryAfterReauth();
          }

        /// ❌ On error
        case ChangePasswordError(:final failure):
          context.showError(failure.toUIEntity());
        default:
          break;
      }
    });
  }

  ////

  /// 📤 Submits the password change request (when the form is valid)
  Future<void> submitChangePassword() async {
    final form = watch(changePasswordFormProvider);
    if (!form.isValid) return;

    final notifier = read(changePasswordProvider.notifier);
    await notifier.changePassword(form.password.value);
  }

  //
}




 */
