part of 'sign_up_page_cubit.dart';

/// 🧾 [SignUpState] — Holds all field values and form status for [SignUpCubit]
/// ✅ Centralized state object for validation, UI, and submission status
//----------------------------------------------------------------
class SignUpState extends Equatable {
  final NameInputValidation name;
  final EmailInputValidation email;
  final PasswordInput password;
  final ConfirmPasswordInput confirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final Failure? failure;
  final bool isPasswordObscure;
  final bool isConfirmPasswordObscure;

  const SignUpState({
    this.name = const NameInputValidation.pure(),
    this.email = const EmailInputValidation.pure(),
    this.password = const PasswordInput.pure(),
    this.confirmPassword = const ConfirmPasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.failure,
    this.isPasswordObscure = true,
    this.isConfirmPasswordObscure = true,
  });

  /// 🧱 Clones current state with optional overrides
  SignUpState copyWith({
    NameInputValidation? name,
    EmailInputValidation? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    FormzSubmissionStatus? status,
    bool? isValid,
    Failure? failure,
    bool? isPasswordObscure,
    bool? isConfirmPasswordObscure,
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      failure: failure,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isConfirmPasswordObscure:
          isConfirmPasswordObscure ?? this.isConfirmPasswordObscure,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    status,
    isValid,
    failure,
    isPasswordObscure,
    isConfirmPasswordObscure,
  ];

  ///
}
