import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/failure_led_retry_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/navigation/extensions/navigation_x_on_context.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import '../../../../app_bootstrap_and_config/di_container/di_container_init.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/utils/_form_validation_service.dart';
import '../../../../core/base_modules/form_fields/input_validation/x_on_forms_submition_status.dart';
import '../../../../core/base_modules/form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/base_modules/form_fields/widgets/password_visibility_icon.dart';
import '../../../../core/base_modules/localization/init_localization.dart';
import '../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../../../core/base_modules/navigation/app_routes/app_routes.dart';
import '../../../../core/base_modules/overlays/core/enums_for_overlay_module.dart';
import '../../../../core/base_modules/overlays/overlay_dispatcher/overlay_status_cubit.dart';
import '../../../../core/base_modules/overlays/utils/overlay_utils.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../../core/base_modules/theme/ui_constants/app_colors.dart';
import '../../../../core/shared_presentation_layer/shared_widgets/buttons/form_submit_button.dart';
import '../../../../core/shared_presentation_layer/shared_widgets/buttons/text_button.dart';
import '../../../../core/utils_shared/spider/images_paths.dart';
import '../../domain/use_cases/sign_in.dart';
import 'cubit/sign_in_page_cubit.dart';

part 'sign_in_widgets.dart';

/// 🔐 [SignInPage] — Entry point for the sign-in feature
/// ✅ Provides scoped Cubit with injected services
//
final class SignInPage extends StatelessWidget {
  ///----------------------------------------
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      create:
          (_) => SignInCubit(di<SignInUseCase>(), di<FormValidationService>()),

      /// 🔄 [_SignInErrorsListener] — Bloc listener for one-shot error feedback.
      /// ✅ Uses `Consumable<FailureUIModel>` for single-use error overlays.
      child: BlocListener<SignInCubit, SignInPageState>(
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
                  () => context.read<SignInCubit>().submit(),
                  context,
                ),
                confirmText: AppLocalizer.translateSafely(
                  LocaleKeys.buttons_retry,
                ),
              );
            } else {
              context.showError(error.toUIEntity(), showAs: ShowAs.infoDialog);
            }

            context.read<SignInCubit>()
              ..resetStatus()
              ..clearFailure();
          }
        },

        ///
        child: const SignInPageView(),
      ),
    );
  }
}

////

////

/// 🔐 [SignInPageView] — Main UI layout for the sign-in form
/// ✅ Uses HookWidget for managing focus nodes & rebuild optimization
//
final class SignInPageView extends HookWidget {
  ///----------------------------------------
  const SignInPageView({super.key});

  @override
  Widget build(BuildContext context) {
    //
    // 📌 Initialize and memoize focus nodes for fields
    final focusNodes = useSignInFocusNodes();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: FocusTraversalGroup(
            child: AutofillGroup(
              child:
                  ///
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.l,
                    ),
                    children: [
                      /// 🖼️ Logo with Hero animation for smooth transitions
                      const _LogoImage(),
                      const SizedBox(height: AppSpacing.l),

                      /// 📧 Email input field
                      _EmailField(
                        focusNode: focusNodes.email,
                        nextFocus: focusNodes.password,
                      ),
                      const SizedBox(height: AppSpacing.l),

                      /// 🔒 Password input field
                      _PasswordField(focusNode: focusNodes.password),
                      const SizedBox(height: AppSpacing.xl),

                      /// 🚀 Primary submit button
                      const _SubmitButton(),
                      const SizedBox(height: AppSpacing.l),

                      /// 🔁 Link to redirect to sign-up screen
                      const _SignInFooter(),
                    ],
                  ).centered(),
            ),
          ),
        ),
      ),
    );
  }

  //
}
