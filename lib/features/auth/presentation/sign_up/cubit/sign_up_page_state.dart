part of 'sign_up_page_cubit.dart';

/// 🗞 [SignUpState] — Holds all field values and form status for [SignUpCubit]
/// ✅ Centralized state object for validation, UI, and submission status
//
final class SignUpState extends Equatable {
  ///-----------------------------------

  final NameInputValidation name;
  final EmailInputValidation email;
  final PasswordInputValidation password;
  final ConfirmPasswordInputValidation confirmPassword;
  final FormzSubmissionStatus status;
  final bool isValid;
  final Consumable<Failure>? failure;
  final bool isPasswordObscure;
  final bool isConfirmPasswordObscure;

  const SignUpState({
    this.name = const NameInputValidation.pure(),
    this.email = const EmailInputValidation.pure(),
    this.password = const PasswordInputValidation.pure(),
    this.confirmPassword = const ConfirmPasswordInputValidation.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.failure,
    this.isPasswordObscure = true,
    this.isConfirmPasswordObscure = true,
  });
  //

  /// 🧱 Clones current state with optional overrides
  // ⚠️ Use only inside `updateWith(...)` to ensure validation is re-applied!
  SignUpState _copyWith({
    final NameInputValidation? name,
    final EmailInputValidation? email,
    final PasswordInputValidation? password,
    final ConfirmPasswordInputValidation? confirmPassword,
    final FormzSubmissionStatus? status,
    final bool? isValid,
    final Consumable<Failure>? failure,
    final bool? isPasswordObscure,
    final bool? isConfirmPasswordObscure,
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

  //
}
