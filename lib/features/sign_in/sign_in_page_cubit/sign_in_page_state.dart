part of 'sign_in_page_cubit.dart';

/// 📄 [SignInPageState] — Stores form field values and state.
class SignInPageState extends Equatable {
  final EmailInput email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final Failure? failure; // 🔄 Замість CustomError

  const SignInPageState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.failure,
  });

  SignInPageState copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    Failure? failure,
  }) {
    return SignInPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [email, password, status, isValid, failure];
}
