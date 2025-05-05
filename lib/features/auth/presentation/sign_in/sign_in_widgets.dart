part of 'sign_in_view.dart';

/// 📧 [_EmailField] — Rebuilds only when email state changes
class _EmailField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextFocus;

  const _EmailField({required this.focusNode, required this.nextFocus});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignInCubit, SignInPageState, String?>(
      selector: (state) => state.email.uiError,
      builder: (context, errorText) {
        return InputFieldFactory.create(
          type: InputFieldType.email,
          focusNode: focusNode,
          errorText: errorText,
          onChanged: context.read<SignInCubit>().emailChanged,
          onSubmitted: () => FocusScope.of(context).requestFocus(nextFocus),
        );
      },
    );
  }
}

/// 🔒 [_PasswordField] — Rebuilds only when password state changes
class _PasswordField extends StatelessWidget {
  final FocusNode focusNode;

  const _PasswordField({required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignInCubit, SignInPageState, String?>(
      selector: (state) => state.password.uiError,
      builder: (context, errorText) {
        return InputFieldFactory.create(
          type: InputFieldType.password,
          focusNode: focusNode,
          errorText: errorText,
          onChanged: context.read<SignInCubit>().passwordChanged,
          onSubmitted: () => context.read<SignInCubit>().submit(),
        );
      },
    );
  }
}

/// 🚀 Sign In Button
class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return FormSubmitButton<SignInCubit, SignInPageState>(
      text: AppStrings.signInButton,
      onSubmit: (context) {
        context.unfocusKeyboard;
        context.read<SignInCubit>().submit();
      },
      statusSelector: (state) => state.status,
      isValidatedSelector: (state) => state.isValid,
    );
  }
}

/// 🔁 Redirect to Sign Up
class _RedirectToSignUpButton extends StatelessWidget {
  const _RedirectToSignUpButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignInCubit, SignInPageState, bool>(
      selector: (state) => state.status.isSubmissionInProgress,
      builder: (context, isLoading) {
        return RedirectTextButton(
          label: AppStrings.redirectToSignUp,
          isDisabled: isLoading,
          onPressed: () => context.pushToNamed(RoutesNames.signUp),
        );
      },
    );
  }
}
