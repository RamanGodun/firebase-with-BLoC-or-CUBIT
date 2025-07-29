import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/failure_led_retry_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import '../../../../app_bootstrap_and_config/di_container/di_container.dart';
import '../../../../core/base_modules/form_fields/utils/_form_validation_service.dart';
import '../../../../core/base_modules/form_fields/input_validation/formz_status_x.dart';
import '../../../../core/base_modules/form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/base_modules/localization/app_localizer.dart';
import '../../../../core/base_modules/overlays/core/enums_for_overlay_module.dart';
import '../../../../core/base_modules/overlays/utils/overlay_utils.dart';
import '../../domain/use_cases/sign_up.dart';
import 'cubit/sign_up_page_cubit.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/localization/generated/locale_keys.g.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/navigation/extensions/navigation_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x.dart';
import '../../../../core/base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../../../core/utils_shared/spider/images_paths.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart'
    show AppSpacing;
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/text_button.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/shared_presentation_layer/widgets_shared/buttons/form_submit_button.dart';
import '../../../../core/base_modules/form_fields/widgets/password_visibility_icon.dart';
import '../../../../core/utils_shared/type_definitions.dart';

part 'sign_up_widgets.dart';

/// 🧾 [SignUpPage] — Entry point for the sign-up feature
/// ✅ Provides scoped Cubit with injected service
//
final class SignUpPage extends StatelessWidget {
  ///-----------------------------------------
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      create:
          (_) => SignUpCubit(di<SignUpUseCase>(), di<FormValidationService>()),

      /// 🔄 [_SignUpListenerWrapper] — Bloc listener for one-shot error feedback.
      /// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.
      child: BlocListener<SignUpCubit, SignUpState>(
        listenWhen:
            (prev, curr) =>
                prev.status != curr.status && curr.status.isSubmissionFailure,

        /// 📣 Show once retryable dialog if supported, otherwise info dialog
        /// and then reset failure + status
        listener: (context, state) {
          final error = state.failure?.consume();
          if (error != null) {
            if (error.isRetryable) {
              context.showError(
                error.toUIEntity(),
                showAs: ShowAs.dialog,
                onConfirm: OverlayUtils.dismissAndRun(
                  () => context.read<SignUpCubit>().submit(),
                  context,
                ),
                confirmText: AppLocalizer.translateSafely(
                  LocaleKeys.buttons_retry,
                ),
              );
            } else {
              context.showError(error.toUIEntity(), showAs: ShowAs.infoDialog);
            }

            context.read<SignUpCubit>()
              ..resetStatus()
              ..clearFailure();
          }
        },

        child: const SignUpView(),
      ),
    );
  }
}

////

////

/// 🧾 [SignUpView] — Full UI layout for Sign Up screen
/// ✅ Includes all form fields, interactions, and field focus handling
//
final class SignUpView extends HookWidget {
  ///------------------------------------
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    //
    // 📌 Shared focus nodes for form fields
    final focusNodes = useSignUpFocusNodes();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          // 🔕 Dismiss keyboard on outside tap
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: ListView(
              shrinkWrap: true,
              children: [
                /// 🔰 Logo with optional hero animation
                const _LogoImage(),
                const SizedBox(height: AppSpacing.l),

                /// 👤 Name input
                _NameField(
                  focusNode: focusNodes.name,
                  nextFocusNode: focusNodes.email,
                ),
                const SizedBox(height: AppSpacing.l),

                /// 📧 Email input
                _EmailField(
                  focusNode: focusNodes.email,
                  nextFocusNode: focusNodes.password,
                ),
                const SizedBox(height: AppSpacing.l),

                /// 🔒 Password input
                _PasswordField(
                  focusNode: focusNodes.password,
                  nextFocusNode: focusNodes.confirmPassword,
                ),
                const SizedBox(height: AppSpacing.l),

                /// 🔐 Confirm password input
                _ConfirmPasswordField(focusNode: focusNodes.confirmPassword),
                const SizedBox(height: AppSpacing.xxxl),

                /// 🚀 Form submission button
                const _SubmitButton(),
                const SizedBox(height: AppSpacing.xxxs),

                /// 🔁 Redirect to Sign In page
                const _RedirectToSignInButton(),
              ],
            ).centered().withPaddingHorizontal(AppSpacing.l),
          ),
        ),
      ),
    );
  }
}
