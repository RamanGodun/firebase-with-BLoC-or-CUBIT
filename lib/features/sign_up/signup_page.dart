// ✅ SignupPage (refactored to match SigninPage structure)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/di/injection.dart';
import '../../core/navigation/route_names.dart';
import '../../core/utils_and_services/errors_handling/error_dialog.dart';
import '../../core/utils_and_services/helper.dart';
import '../../core/utils_and_services/form_fields_input/forms_status_extension.dart';
import '../../presentation/widgets/buttons/button_for_forms.dart';
import '../../presentation/widgets/buttons/text_button.dart';
import '../../presentation/widgets/input_fields.dart/email_input_field.dart';
import '../../presentation/widgets/input_fields.dart/password_confirmation_input_filed.dart';
import '../../presentation/widgets/input_fields.dart/password_input_field.dart';
import '../../presentation/widgets/input_fields.dart/name_input_field.dart';
import 'signup_cubit/sign_up_page_cubit.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(authRepository: appSingleton()),
      child: BlocListener<SignUpCubit, SignUpState>(
        listenWhen:
            (prev, curr) =>
                prev.status != curr.status && curr.status.isSubmissionFailure,
        listener: (context, state) {
          AppDialogs.showErrorDialog(context, state.error);
          context.read<SignUpCubit>().resetStatus();
        },
        child: const SignUpView(),
      ),
    );
  }
}

class SignUpView extends HookWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameFocus = useFocusNode();
    final emailFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final confirmPasswordFocus = useFocusNode();

    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Image.asset('assets/images/flutter_logo.png', height: 150),
                    const SizedBox(height: 20),

                    /// Full name field
                    NameInputField(
                      focusNode: nameFocus,
                      errorText: state.name.errorText,
                      onChanged:
                          (val) =>
                              context.read<SignUpCubit>().onNameChanged(val),
                      onSubmitted:
                          () => FocusScope.of(context).requestFocus(emailFocus),
                    ),
                    const SizedBox(height: 20),

                    /// Email field
                    EmailInputField(
                      focusNode: emailFocus,
                      errorText: state.email.displayError,
                      onChanged:
                          (val) =>
                              context.read<SignUpCubit>().onEmailChanged(val),
                      onSubmitted:
                          () => FocusScope.of(
                            context,
                          ).requestFocus(passwordFocus),
                    ),
                    const SizedBox(height: 20),

                    /// Password field
                    PasswordInputField(
                      focusNode: passwordFocus,
                      errorText: state.password.displayError,
                      onChanged:
                          (val) => context
                              .read<SignUpCubit>()
                              .onPasswordChanged(val),
                      onSubmitted:
                          () => FocusScope.of(
                            context,
                          ).requestFocus(confirmPasswordFocus),
                    ),
                    const SizedBox(height: 20),

                    /// Confirm password field
                    ConfirmPasswordInputField(
                      focusNode: confirmPasswordFocus,
                      errorText: state.confirmPassword.errorText,
                      onChanged:
                          (val) => context
                              .read<SignUpCubit>()
                              .onConfirmPasswordChanged(val),
                      onSubmitted:
                          () => context.read<SignUpCubit>().submitForm(),
                    ),
                    const SizedBox(height: 50),

                    /// Submit button
                    ReusableFormSubmitButton<SignUpCubit, SignUpState>(
                      text: 'Sign Up',
                      onSubmit: _onSubmit,
                      statusSelector: (state) => state.status,
                      isValidatedSelector: (state) => state.isValid,
                    ),
                    const SizedBox(height: 10),

                    /// Redirect to Sign In
                    RedirectTextButton(
                      label: 'Already a member? Sign In!',
                      isDisabled: state.status.isSubmissionInProgress,
                      onPressed: () => Helpers.goTo(context, RouteNames.signin),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onSubmit(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<SignUpCubit>().submitForm();
  }
}
