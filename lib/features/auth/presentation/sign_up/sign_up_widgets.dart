part of 'sign_up_view.dart';

/// 👤 Name field
class _NameField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  const _NameField({required this.focusNode, required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, String?>(
      selector: (state) => state.name.uiError,
      builder: (context, errorText) {
        return InputFieldFactory.create(
          type: InputFieldType.name,
          focusNode: focusNode,
          errorText: errorText,
          onChanged: (val) => context.read<SignUpCubit>().onNameChanged(val),
          onSubmitted: () => nextFocusNode.requestFocus(),
        );
      },
    );
  }
}

/// 📧 Email field
class _EmailField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  const _EmailField({required this.focusNode, required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, String?>(
      selector: (state) => state.email.displayError,
      builder: (context, errorText) {
        return InputFieldFactory.create(
          type: InputFieldType.email,
          focusNode: focusNode,
          errorText: errorText,
          onChanged: (val) => context.read<SignUpCubit>().onEmailChanged(val),
          onSubmitted: () => nextFocusNode.requestFocus(),
        );
      },
    );
  }
}

/// 🔒 Password field
class _PasswordField extends StatelessWidget {
  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  const _PasswordField({required this.focusNode, required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, String?>(
      selector: (state) => state.password.displayError,
      builder: (context, errorText) {
        return InputFieldFactory.create(
          type: InputFieldType.password,
          focusNode: focusNode,
          errorText: errorText,
          onChanged:
              (val) => context.read<SignUpCubit>().onPasswordChanged(val),
          onSubmitted: () => nextFocusNode.requestFocus(),
        );
      },
    );
  }
}

/// 🔐 Confirm password field
class _ConfirmPasswordField extends StatelessWidget {
  final FocusNode focusNode;
  const _ConfirmPasswordField({required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, String?>(
      selector: (state) => state.confirmPassword.uiError,
      builder: (context, errorText) {
        return InputFieldFactory.create(
          type: InputFieldType.confirmPassword,
          focusNode: focusNode,
          errorText: errorText,
          onChanged:
              (val) =>
                  context.read<SignUpCubit>().onConfirmPasswordChanged(val),
          onSubmitted: () => context.read<SignUpCubit>().submit(),
        );
      },
    );
  }
}

/// 🚀 Submit button
class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    return FormSubmitButton<SignUpCubit, SignUpState>(
      text: AppStrings.signUpButton,
      onSubmit: (context) {
        context.unfocusKeyboard;
        context.read<SignUpCubit>().submit();
      },
      statusSelector: (state) => state.status,
      isValidatedSelector: (state) => state.isValid,
    );
  }
}

/// 🔁 Redirect to Sign In
class _RedirectToSignInButton extends StatelessWidget {
  const _RedirectToSignInButton();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SignUpCubit, SignUpState, bool>(
      selector: (state) => state.status.isSubmissionInProgress,
      builder: (context, isLoading) {
        return RedirectTextButton(
          label: AppStrings.redirectToSignIn,
          isDisabled: isLoading,
          onPressed: () => context.popView(),
        );
      },
    );
  }
}
