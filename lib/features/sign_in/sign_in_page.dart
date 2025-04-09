import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/di/injection.dart';
import '../../core/navigation/route_names.dart';
import '../../core/utils_and_services/errors_handling/error_dialog.dart';
import '../../core/utils_and_services/form_fields_validation/forms_status_extension.dart';
import '../../core/utils_and_services/helper.dart';
import '../../presentation/widgets/buttons/button_for_forms.dart';
import '../../presentation/widgets/buttons/text_button.dart';
import '../../presentation/widgets/input_fields.dart/email_input_field.dart';
import '../../presentation/widgets/input_fields.dart/password_input_field.dart';
import 'sign_in_page_cubit/sign_in_page_cubit.dart';

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
        child: const SigninPageView(),
      ),
    );
  }
}

class SigninPageView extends HookWidget {
  const SigninPageView({super.key});

  @override
  Widget build(BuildContext context) {
    // 📌 FocusNodes for keyboard navigation and form UX
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();

    return BlocBuilder<SignInCubit, SignInPageState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AutofillGroup(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      /// Build image
                      Hero(
                        tag: 'Logo',
                        child: Image.asset(
                          'assets/images/flutter_logo.png',
                          width: 250,
                        ),
                      ),
                      const SizedBox(height: 20),

                      /// Build the textfields
                      EmailInputField(
                        focusNode: emailFocusNode,
                        errorText: state.email.displayError,
                        onChanged:
                            (value) =>
                                context.read<SignInCubit>().emailChanged(value),
                        onSubmitted: () => FocusScope.of(context).nextFocus(),
                      ),
                      const SizedBox(height: 20),

                      PasswordInputField(
                        focusNode: passwordFocusNode,
                        errorText: state.password.displayError,
                        onChanged:
                            (value) => context
                                .read<SignInCubit>()
                                .passwordChanged(value),
                        onSubmitted: () => context.read<SignInCubit>().submit(),
                      ),
                      const SizedBox(height: 20),

                      /// Build the submit button (universal reusable button with loading state)
                      FormSubmitButton<SignInCubit, SignInPageState>(
                        text: 'Sign In',
                        onSubmit: _submit,
                        statusSelector: (state) => state.status,
                        isValidatedSelector: (state) => state.isValid,
                      ),
                      const SizedBox(height: 10),

                      ///Build sign-up redirection text button
                      RedirectTextButton(
                        label: 'Not a member? Sign Up!',
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

  // ======================= 🔻 PRIVATE METHODS 🔻 ======================= //

  /// Unfocus all input fields (used when tapping outside the keyboard)
  void _unfocusFields(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// Submit sign-in form through the form cubit
  void _submit(BuildContext context) {
    _unfocusFields(context);
    context.read<SignInCubit>().submit();
  }

  ///
}
