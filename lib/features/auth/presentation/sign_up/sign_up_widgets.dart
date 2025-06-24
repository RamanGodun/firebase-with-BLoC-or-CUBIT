part of 'sign_up_view.dart';

/// 🖼️ [_LogoImage] — Displays logo with hero animation

final class _LogoImage extends StatelessWidget {
  ///-----------------------------------------
  const _LogoImage();

  @override
  Widget build(BuildContext context) {
    //
    return const Hero(
      tag: 'Logo',
      child: Image(image: AssetImage(ImagesPaths.flutterLogo), height: 150),
    );
  }
}

////

////

/// 👤 [_NameField] — Handles name input with validation

final class _NameField extends StatelessWidget {
  //-------------------------------------------

  final FocusNode focusNode;
  final FocusNode nextFocusNode;
  const _NameField({required this.focusNode, required this.nextFocusNode});
  //

  @override
  Widget build(BuildContext context) {
    //
    return BlocSelector<SignUpCubit, SignUpState, String?>(
      selector: (state) => state.name.uiErrorKey,
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

////

////

/// 📧 [_EmailField] — Handles email input with validation

final class _EmailField extends StatelessWidget {
  //--------------------------------------------

  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  const _EmailField({required this.focusNode, required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    //
    return BlocSelector<SignUpCubit, SignUpState, String?>(
      selector: (state) => state.email.uiErrorKey,
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

////

////

/// 🔒 [_PasswordField] — Handles password input with toggle visibility

final class _PasswordField extends StatelessWidget {
  //-----------------------------------------------

  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  const _PasswordField({required this.focusNode, required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    //
    return BlocSelector<SignUpCubit, SignUpState, FieldUiState>(
      selector:
          (state) => (
            errorText: state.password.uiErrorKey,
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
      },
    );
  }
}

////

////

/// 🔐 [_ConfirmPasswordField] — Validates match with password

final class _ConfirmPasswordField extends StatelessWidget {
  //-----------------------------------------------------

  final FocusNode focusNode;

  const _ConfirmPasswordField({required this.focusNode});

  @override
  Widget build(BuildContext context) {
    //
    return BlocSelector<SignUpCubit, SignUpState, FieldUiState>(
      selector:
          (state) => (
            errorText: state.confirmPassword.uiErrorKey,
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
      },
    );
  }
}

////

////

/// 🚀 [_SubmitButton] — Validated submit with status feedback

final class _SubmitButton extends StatelessWidget {
  //----------------------------------------------

  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    //
    return FormSubmitButton<SignUpCubit, SignUpState>(
      text: LocaleKeys.buttons_sign_up,
      onSubmit: (context) {
        context.unfocusKeyboard;
        context.read<SignUpCubit>().submit();
      },
      statusSelector: (state) => state.status,
      isValidatedSelector: (state) => state.isValid,
    );
  }
}

////

////

/// 🔁 [_RedirectToSignInButton] — Disabled if submitting or overlay active

final class _RedirectToSignInButton extends StatelessWidget {
  //--------------------------------------------------------

  const _RedirectToSignInButton();

  @override
  Widget build(BuildContext context) {
    //
    final isOverlayActive = context.select<OverlayStatusCubit, bool>(
      (cubit) => cubit.state,
    );

    return BlocSelector<SignUpCubit, SignUpState, bool>(
      selector: (state) => state.status.isSubmissionInProgress,
      builder: (context, isLoading) {
        final isDisabled = isLoading || isOverlayActive;

        return RedirectTextButton(
          label: LocaleKeys.buttons_to_sign_in,
          isDisabled: isDisabled,
          onPressed: () => context.popView(),
        );
      },
    );
  }
}
