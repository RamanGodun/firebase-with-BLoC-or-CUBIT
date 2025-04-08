part of 'sign_in_page_cubit.dart';

class SignInPageState extends Equatable {
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

  /// Creates a copy of the current state with optional overrides
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

  /// Needed for state comparison and BlocBuilder optimizations
  @override
  List<Object?> get props => [email, password, status, isValid, error];
}
