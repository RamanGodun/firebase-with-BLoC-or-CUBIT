part of 'sign_in_page_cubit.dart';

/// 📄 [SignInPageState] — Stores form field values and validation status
/// ✅ Used by [SignInCubit] to manage UI state reactively
//----------------------------------------------------------------

class SignInPageState extends Equatable {
  final EmailInputValidation email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final Consumable<Failure>? failure;
  final bool isPasswordObscure;

  /// 🧱 Initial constructor with default values
  const SignInPageState({
    this.email = const EmailInputValidation.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.failure,
    this.isPasswordObscure = true,
  });

  /// 🔁 Returns new instance with optional overridden fields
  SignInPageState copyWith({
    EmailInputValidation? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    Consumable<Failure>? failure,
    bool? isPasswordObscure,
  }) {
    return SignInPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      failure: failure ?? this.failure,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
    );
  }

  /// 🧪 Required for equality comparison in Bloc rebuilds
  @override
  List<Object?> get props => [
    email,
    password,
    status,
    isValid,
    failure,
    isPasswordObscure,
  ];

  ///
}
