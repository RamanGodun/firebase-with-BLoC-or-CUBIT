import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../core/di/injection.dart';
import '../../core/navigation/route_names.dart';
import '../../core/utils_and_services/errors_handling/error_dialog.dart';
import '../../core/utils_and_services/form_fields_input/forms_status_extension.dart';
import '../../core/utils_and_services/helper.dart';
import '../../presentation/widgets/buttons/button_for_forms.dart';
import '../../presentation/widgets/buttons/text_button.dart';
import 'sign_in_page_cubit/signin_form_cubit.dart';

part 'sign_in_fields.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SigninFormCubit(authRepository: appSingleton()),
      child: BlocListener<SigninFormCubit, SigninFormState>(
        listenWhen:
            (prev, current) =>
                prev.status != current.status &&
                current.status.isSubmissionFailure,
        listener: (context, state) {
          AppDialogs.showErrorDialog(context, state.error);
          context.read<SigninFormCubit>().resetStatus();
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

    // 📌 Clean up FocusNodes when the widget is disposed
    useEffect(() {
      return () {
        emailFocusNode.dispose();
        passwordFocusNode.dispose();
      };
    }, const []);

    return BlocBuilder<SigninFormCubit, SigninFormState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _unfocusFields(context),
          child: Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: AutofillGroup(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Image.asset('assets/images/flutter_logo.png', width: 250),

                      /// Build the textfields
                      const SizedBox(height: 20),
                      _EmailField(focusNode: emailFocusNode),
                      const SizedBox(height: 20),
                      _PasswordField(focusNode: passwordFocusNode),
                      const SizedBox(height: 20),

                      /// Build the submit button (universal reusable button with loading state)
                      ReusableFormSubmitButton<
                        SigninFormCubit,
                        SigninFormState
                      >(
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
                            () => Helpers.goTo(context, RouteNames.signup),
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
    context.read<SigninFormCubit>().submit();
  }

  ///
}
