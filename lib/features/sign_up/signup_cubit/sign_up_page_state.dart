part of 'sign_up_page_cubit.dart';

class SignupPageState {
  final NameInput name;
  final EmailInput email;
  final PasswordInput password;
  final ConfirmPasswordInput confirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final CustomError error;

  const SignupPageState({
    this.name = const NameInput.pure(),
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.error = const CustomError(),
  });

  SignupPageState copyWith({
    NameInput? name,
    EmailInput? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    CustomError? error,
  }) {
    return SignupPageState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
    );
  }
}

enum SignupStatus { initial, submitting, success, error }
