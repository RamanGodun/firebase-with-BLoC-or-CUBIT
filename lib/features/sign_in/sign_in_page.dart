import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../core/constants/app_constants.dart' show AppSpacing;
import '../../core/constants/app_strings.dart';
import '../../core/di/injection.dart';
import '../../core/navigation/router.dart' show RouteNames;
import '../../core/utils_and_services/errors_handling/error_dialog.dart';
import '../../core/utils_and_services/form_fields_validation_and_extension/forms_status_extension.dart';
import '../../core/utils_and_services/helpers.dart';
import '../../presentation/widgets/buttons/button_for_forms.dart';
import '../../presentation/widgets/buttons/text_button.dart';
import '../../presentation/widgets/input_fields.dart/email_input_field.dart';
import '../../presentation/widgets/input_fields.dart/password_input_field.dart';
import 'sign_in_page_cubit/sign_in_page_cubit.dart';

/// 🔐 [SignInPage] - Auth screen for existing users
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(authRepository: appSingleton()),
      child: BlocListener<SignInCubit, SignInPageState>(
        listenWhen:
            (prev, current) =>
                prev.status != current.status &&
                current.status.isSubmissionFailure,
        listener: (context, state) {
          AppDialogs.showErrorDialog(context, state.error);
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
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
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
                            (value) =>
                                context.read<SignInCubit>().emailChanged(value),
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
                            () =>
                                Helpers.pushToNamed(context, RouteNames.signUp),
                      ),
                    ],
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
