import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/constants/app_constants.dart' show AppSpacing;
import '../../core/constants/app_strings.dart';
import '../../core/di/di_container.dart';
import '../../core/utils_and_services/helpers.dart';
import '../../core/utils_and_services/form_fields_validation_and_extension/forms_status_extension.dart';
import '../../presentation/widgets/buttons/button_for_forms.dart';
import '../../presentation/widgets/buttons/text_button.dart';
import '../../presentation/widgets/input_fields.dart/email_input_field.dart';
import '../../presentation/widgets/input_fields.dart/name_input_field.dart';
import '../../presentation/widgets/input_fields.dart/password_input_field.dart';
import '../../presentation/widgets/input_fields.dart/password_confirmation_input_filed.dart';
import 'signup_cubit/sign_up_page_cubit.dart';

/// 🧾 [SignUpPage] - Entry point with BLoC provider and listener
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(authRepository: di()),
      child: BlocListener<SignUpCubit, SignUpState>(
        listenWhen:
            (prev, curr) =>
                prev.status != curr.status && curr.status.isSubmissionFailure,
        listener: (context, state) {
          if (state.failure != null) {
            context.showFailureDialog(state.failure!);
            context.read<SignUpCubit>().resetStatus();
          }
        },
        child: const SignUpView(),
      ),
    );
  }
}

/// 🧾 [SignUpView] - Contains full form UI and field logic
class SignUpView extends HookWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔤 Focus management
    final nameFocus = useFocusNode();
    final emailFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final confirmPasswordFocus = useFocusNode();

    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onTap: context.unfocusKeyboard,
              child: Center(
                child: FocusTraversalGroup(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      /// 🔰 App Logo with Hero animation
                      const Hero(
                        tag: 'Logo',
                        child: Image(
                          image: AssetImage('assets/images/flutter_logo.png'),
                          height: 150,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.l),

                      /// 👤 Full Name
                      NameInputField(
                        focusNode: nameFocus,
                        errorText: state.name.errorText,
                        onChanged:
                            (val) =>
                                context.read<SignUpCubit>().onNameChanged(val),
                        onSubmitted:
                            () =>
                                FocusScope.of(context).requestFocus(emailFocus),
                      ),
                      const SizedBox(height: AppSpacing.l),

                      /// 📧 Email
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
                      const SizedBox(height: AppSpacing.l),

                      /// 🔒 Password
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
                      const SizedBox(height: AppSpacing.l),

                      /// 🔐 Confirm Password
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
                      const SizedBox(height: AppSpacing.xxxl),

                      /// 🚀 Submit Button with animation
                      FormSubmitButton<SignUpCubit, SignUpState>(
                        text: AppStrings.signUpButton,
                        onSubmit: _onSubmit,
                        statusSelector: (state) => state.status,
                        isValidatedSelector: (state) => state.isValid,
                      ),
                      const SizedBox(height: AppSpacing.s),

                      /// 🔁 Redirect to Sign In
                      RedirectTextButton(
                        label: AppStrings.redirectToSignIn,
                        isDisabled: state.status.isSubmissionInProgress,
                        onPressed: () => Helpers.pop(context),
                      ),
                    ],
                  ).withPaddingHorizontal(AppSpacing.xl),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔽 Handles form submission logic
  void _onSubmit(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<SignUpCubit>().submitForm();
  }
}
