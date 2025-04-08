// 📄 signin_form_state.dart
part of 'sign_in_page_cubit.dart';

class SignInPageState {
  final EmailInput email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final CustomError error;

  const SignInPageState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.error = const CustomError(),
  });

  SignInPageState copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    CustomError? error,
  }) {
    return SignInPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }
}
