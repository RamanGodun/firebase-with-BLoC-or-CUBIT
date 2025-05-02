import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../../../core/presentation/constants/app_constants.dart' show AppSpacing;
import '../../../../core/presentation/constants/app_strings.dart';
import '../../../../core/app_config/bootstrap/di_container.dart';
import '../../../../core/shared_moduls/navigation/_imports_for_router.dart' show RoutesNames;
import '../../../../core/shared_moduls/form_fields/forms_status_extension.dart';
import '../../../../core/shared_moduls/overlay/_overlay_service.dart';
import '../../../../core/presentation/shared_widgets/buttons/button_for_forms.dart';
import '../../../../core/presentation/shared_widgets/buttons/text_button.dart';
import '../../../../core/shared_moduls/form_fields/input_fields.dart/email_input_field.dart';
import '../../../../core/shared_moduls/form_fields/input_fields.dart/password_input_field.dart';
import 'sign_in_page_cubit/sign_in_page_cubit.dart';

/// 🔐 [SignInPage] - Auth screen for existing users
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(authRepository: di()),
      child: BlocListener<SignInCubit, SignInPageState>(
        listenWhen:
            (prev, current) =>
                prev.status != current.status &&
                current.status.isSubmissionFailure,
        listener: (context, state) {
          if (state.failure != null) {
            OverlayNotificationService.dismissIfVisible();
            context.showFailureDialog(state.failure!);
          }
          context.read<SignInCubit>().resetStatus();
        },
        child: const SignInPageView(),
      ),
    );
  }
}

/// 🔐 [SignInPageView] - Full sign-in form UI with reactive logic
class SignInPageView extends HookWidget {
  const SignInPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    return BlocBuilder<SignInCubit, SignInPageState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onTap: context.unfocusKeyboard,
              child: Center(
                child: FocusTraversalGroup(
                  child: AutofillGroup(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        /// 🖼️ Logo with Hero animation
                        const Hero(
                          tag: 'Logo',
                          child: Image(
                            image: AssetImage('assets/images/flutter_logo.png'),
                            width: 250,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.l),

                        /// 📧 Email
                        EmailInputField(
                          focusNode: emailFocusNode,
                          errorText: state.email.displayError,
                          onChanged:
                              (value) => context
                                  .read<SignInCubit>()
                                  .emailChanged(value),
                          onSubmitted:
                              () => FocusScope.of(
                                context,
                              ).requestFocus(passwordFocusNode),
                        ),
                        const SizedBox(height: AppSpacing.l),

                        /// 🔒 Password
                        PasswordInputField(
                          focusNode: passwordFocusNode,
                          errorText: state.password.displayError,
                          onChanged:
                              (value) => context
                                  .read<SignInCubit>()
                                  .passwordChanged(value),
                          onSubmitted: () => _submit(context),
                        ),
                        const SizedBox(height: AppSpacing.xl),

                        /// 🚀 Sign In Button
                        FormSubmitButton<SignInCubit, SignInPageState>(
                          text: AppStrings.signInButton,
                          onSubmit: _submit,
                          statusSelector: (state) => state.status,
                          isValidatedSelector: (state) => state.isValid,
                        ),
                        const SizedBox(height: AppSpacing.s),

                        /// 🔁 Sign Up Redirect
                        RedirectTextButton(
                          label: AppStrings.redirectToSignUp,
                          isDisabled: state.status.isSubmissionInProgress,
                          onPressed:
                              () => context.pushToNamed(RoutesNames.signUp),
                        ),
                      ],
                    ).withPaddingHorizontal(AppSpacing.xl),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔄 Submit the form
  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<SignInCubit>().submit();
  }
}
