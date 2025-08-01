import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/form_fields/input_validation/x_on_forms_submition_status.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/navigation/utils/extensions/navigation_x_on_context.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_context_x_for_overlays.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_overlay_base_methods.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/extensions/extension_on_widget/_widget_x_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:formz/formz.dart' show FormzSubmissionStatus;
import '../../../../app_bootstrap_and_config/di_container/di_container_init.dart';
import '../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../core/base_modules/form_fields/utils/_form_validation_service.dart';
import '../../../../core/base_modules/form_fields/utils/use_auth_focus_nodes.dart';
import '../../../../core/base_modules/form_fields/widgets/_fields_factory.dart';
import '../../../../core/base_modules/localization/module_widgets/text_widget.dart';
import '../../../../core/base_modules/navigation/routes/app_routes.dart';
import '../../../../core/base_modules/theme/ui_constants/_app_constants.dart';
import '../../../../core/shared_presentation_layer/shared_widgets/buttons/form_submit_button.dart';
import '../../../../core/shared_presentation_layer/shared_widgets/buttons/text_button.dart';
import '../../../../core/utils_shared/extensions/context_extensions/_context_extensions.dart';
import '../../../../core/base_modules/localization/generated/locale_keys.g.dart';
import '../../domain/password_actions_use_case.dart';
import 'cubits/reset_password_cubit.dart';

part 'widgets_for_reset_password_page.dart';

/// 🔐 [ResetPasswordPage] — allows user to request password reset
/// 🔁 Declarative side-effect for [ResetPasswordPage]
//
final class ResetPasswordPage extends StatelessWidget {
  ///---------------------------------------
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return BlocProvider(
      create:
          (_) => ResetPasswordCubit(
            di<PasswordRelatedUseCases>(),
            di<FormValidationService>(),
          ),
      child: MultiBlocListener(
        listeners: [
          /// ❌ Error Listener
          BlocListener<ResetPasswordCubit, ResetPasswordState>(
            listenWhen:
                (prev, curr) =>
                    prev.status != curr.status &&
                    curr.status.isSubmissionFailure,
            listener: (context, state) {
              final error = state.failure?.consume();
              if (error != null) {
                context.showError(error.toUIEntity());
                context.read<ResetPasswordCubit>().clearFailure();
              }
            },
          ),

          /// ✅ Success Listener
          BlocListener<ResetPasswordCubit, ResetPasswordState>(
            listenWhen:
                (prev, curr) =>
                    prev.status != curr.status &&
                    curr.status.isSubmissionSuccess,
            listener: (context, state) {
              context.showSnackbar(message: LocaleKeys.reset_password_success);
              // 🧭 Navigation after success
              context.goTo(RoutesNames.signIn);
            },
          ),
        ],

        child: const _ResetPasswordView(),
      ),
    );
  }
}

/// 🔐 [_ResetPasswordView] — screen that allows user to request password reset
/// 📩 Sends reset link to user's email using [ResetPasswordProvider]
//
final class _ResetPasswordView extends StatelessWidget {
  ///------------------------------------------------
  const _ResetPasswordView();

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: context.unfocusKeyboard,
          child: ListView(
            shrinkWrap: true,
            children: const [
              //
              _ResetPasswordHeader(),

              _ResetPasswordEmailInputField(),
              SizedBox(height: AppSpacing.huge),

              _ResetPasswordSubmitButton(),
              SizedBox(height: AppSpacing.xxxs),

              _ResetPasswordFooter(),
            ],
          ).withPaddingHorizontal(AppSpacing.l),
        ),
      ),
    );
  }
}
