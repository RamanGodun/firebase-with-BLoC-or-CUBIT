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
          onChanged: context.read<SignUpCubit>().onNameChanged,
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
      selector: (state) => state.email.uiError,
      builder: (context, errorText) {
        return InputFieldFactory.create(
          type: InputFieldType.email,
          focusNode: focusNode,
          errorText: errorText,
          onChanged: context.read<SignUpCubit>().onEmailChanged,
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
    return BlocSelector<SignUpCubit, SignUpState, FieldUiState>(
      selector:
          (state) => (
            errorText: state.password.uiError,
            isObscure: state.isPasswordObscure,
          ),
      builder: (context, field) {
        final (errorText: errorText, isObscure: isObscure) = field;

        return InputFieldFactory.create(
          type: InputFieldType.password,
          focusNode: focusNode,
          errorText: errorText,
          isObscure: isObscure,
          suffixIcon: ObscureToggleIcon(
            isObscure: isObscure,
            onPressed: context.read<SignUpCubit>().togglePasswordVisibility,
          ),
          onChanged: context.read<SignUpCubit>().onPasswordChanged,
          onSubmitted: () => nextFocusNode.requestFocus(),
        );
        //
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
    return BlocSelector<SignUpCubit, SignUpState, FieldUiState>(
      selector:
          (state) => (
            errorText: state.confirmPassword.uiError,
            isObscure: state.isConfirmPasswordObscure,
          ),
      builder: (context, field) {
        final (errorText: errorText, isObscure: isObscure) = field;

        return InputFieldFactory.create(
          type: InputFieldType.confirmPassword,
          focusNode: focusNode,
          errorText: errorText,
          isObscure: isObscure,
          suffixIcon: ObscureToggleIcon(
            isObscure: isObscure,
            onPressed:
                context.read<SignUpCubit>().toggleConfirmPasswordVisibility,
          ),
          onChanged: context.read<SignUpCubit>().onConfirmPasswordChanged,
          onSubmitted: context.read<SignUpCubit>().submit,
        );
        //
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
