part of 'sign_in_page.dart';

/// Email input field with external focus node control
class _EmailField extends HookWidget {
  final FocusNode focusNode;

  const _EmailField({required this.focusNode});

  @override
  Widget build(BuildContext context) {
    useEffect(() => () => focusNode.dispose(), const []);
    final state = context.watch<SigninFormCubit>().state;

    return TextField(
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email),
        errorText: state.email.displayError,
      ),
      onChanged: (value) => context.read<SigninFormCubit>().emailChanged(value),
      onSubmitted: (_) => FocusScope.of(context).nextFocus(),
    );
  }
}

/// Password input field with external focus node control
class _PasswordField extends HookWidget {
  final FocusNode focusNode;

  const _PasswordField({required this.focusNode});

  @override
  Widget build(BuildContext context) {
    useEffect(() => () => focusNode.dispose(), const []);
    final state = context.watch<SigninFormCubit>().state;

    return TextField(
      focusNode: focusNode,
      obscureText: true,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        errorText: state.password.displayError,
      ),
      onChanged:
          (value) => context.read<SigninFormCubit>().passwordChanged(value),
      onSubmitted: (_) => context.read<SigninFormCubit>().submit(),
    );
  }
}
