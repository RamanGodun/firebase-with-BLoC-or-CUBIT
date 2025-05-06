part of 'sign_in_view.dart';

/// 🖼️ [_LogoImage] — Displays Flutter logo with hero animation
//----------------------------------------------------------------
final class _LogoImage extends StatelessWidget {
  const _LogoImage();

  @override
  Widget build(BuildContext context) {
    return const Hero(
      tag: 'Logo',
      child: Image(
        image: AssetImage('assets/images/flutter_logo.png'),
        width: 250,
      ),
    );
  }
}

/// 📧 [_EmailField] — Email input field with validation & focus handling
/// ✅ Rebuilds only when `email.uiError` changes
//----------------------------------------------------------------
final class _EmailField extends StatelessWidget {
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

/// 🔒 [_PasswordField] — Password field with toggle visibility logic
/// ✅ Rebuilds only when password error or visibility state changes
//----------------------------------------------------------------
final class _PasswordField extends StatelessWidget {
  final FocusNode focusNode;

  const _PasswordField({required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      SignInCubit,
      SignInPageState,
      ({String? errorText, bool isObscure})
    >(
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
            onPressed: context.read<SignInCubit>().togglePasswordVisibility,
          ),
          onChanged: context.read<SignInCubit>().passwordChanged,
          onSubmitted: () => context.read<SignInCubit>().submit(),
        );
      },
    );
  }
}

/// 🚀 [_SubmitButton] — Button for triggering sign-in logic
/// ✅ Uses [FormSubmitButton] for automatic loading state binding
//----------------------------------------------------------------
final class _SubmitButton extends StatelessWidget {
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

/// 🔁 [_RedirectToSignUpButton] — Button to navigate to the sign-up screen
/// ✅ Disabled during form submission
//----------------------------------------------------------------
final class _RedirectToSignUpButton extends StatelessWidget {
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
