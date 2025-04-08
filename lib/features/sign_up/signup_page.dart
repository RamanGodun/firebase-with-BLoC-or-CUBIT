// ✅ SignupPage (refactored to match SigninPage structure)
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
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

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupPageCubit(authRepository: appSingleton()),
      child: BlocListener<SignupPageCubit, SignupPageState>(
        listenWhen:
            (prev, current) =>
                prev.status != current.status &&
                current.status.isSubmissionFailure,
        listener: (context, state) {
          AppDialogs.showErrorDialog(context, state.error);
          context.read<SignupPageCubit>().resetStatus();
        },
        child: const SignupPageView(),
      ),
    );
  }
}

class SignupPageView extends HookWidget {
  const SignupPageView({super.key});

  @override
  Widget build(BuildContext context) {
    print('🔁 SignupPageView.build called');
    final nameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final confirmPasswordFocusNode = useFocusNode();

    /// ✅ Set initial autofocus on [nameFocusNode]
    useEffect(() {
      SchedulerBinding.instance.endOfFrame.then((_) {
        debugPrint('🎯 [LOG] Focus after endOfFrame');
        FocusScope.of(context).requestFocus(nameFocusNode);
      });
      return null;
    }, const []);

    ///
    return BlocBuilder<SignupPageCubit, SignupPageState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            print('💬 GestureDetector tapped — calling unfocus()');
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SingleChildScrollView(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Image.asset(
                        'assets/images/flutter_logo.png',
                        height: 150,
                      ),
                      const SizedBox(height: 20),

                      ///
                      NameInputField(
                        focusNode: nameFocusNode,
                        errorText: state.name.errorText,
                        onChanged:
                            (value) => context
                                .read<SignupPageCubit>()
                                .nameChanged(value),
                        onSubmitted:
                            () => FocusScope.of(
                              context,
                            ).requestFocus(emailFocusNode),
                      ),
                      const SizedBox(height: 20),

                      ///
                      EmailInputField(
                        focusNode: emailFocusNode,
                        errorText: state.email.displayError,
                        onChanged:
                            (value) => context
                                .read<SignupPageCubit>()
                                .emailChanged(value),
                        onSubmitted:
                            () => FocusScope.of(
                              context,
                            ).requestFocus(passwordFocusNode),
                      ),
                      const SizedBox(height: 20),
                      PasswordInputField(
                        focusNode: passwordFocusNode,
                        errorText: state.password.displayError,
                        onChanged:
                            (value) => context
                                .read<SignupPageCubit>()
                                .passwordChanged(value),
                        onSubmitted:
                            () => FocusScope.of(
                              context,
                            ).requestFocus(confirmPasswordFocusNode),
                      ),
                      const SizedBox(height: 20),

                      /// Password confirmation
                      ConfirmPasswordInputField(
                        focusNode: confirmPasswordFocusNode,
                        errorText: state.confirmPassword.errorText,
                        onChanged:
                            (value) => context
                                .read<SignupPageCubit>()
                                .confirmPasswordChanged(value),
                        onSubmitted:
                            () => context.read<SignupPageCubit>().submit(),
                      ),

                      const SizedBox(height: 50),
                      ReusableFormSubmitButton<
                        SignupPageCubit,
                        SignupPageState
                      >(
                        text: 'Sign Up',
                        onSubmit: _submit,
                        statusSelector: (state) => state.status,
                        isValidatedSelector: (state) => state.isValid,
                      ),
                      const SizedBox(height: 10),
                      RedirectTextButton(
                        label: 'Already a member? Sign In!',
                        isDisabled: state.status.isSubmissionInProgress,
                        onPressed:
                            () => Helpers.goTo(context, RouteNames.signin),
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

  void _submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    context.read<SignupPageCubit>().submit();
  }
}
