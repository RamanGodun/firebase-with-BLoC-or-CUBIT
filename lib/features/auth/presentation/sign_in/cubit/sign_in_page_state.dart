part of 'sign_in_page_cubit.dart';

/// 📄 [SignInPageState] — Stores form field values and validation status
/// ✅ Used by [SignInCubit] to manage UI state reactively
//----------------------------------------------------------------

class SignInPageState extends Equatable {
  final EmailInputValidation email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final Consumable<FailureUIModel>? failure;
  final bool isPasswordObscure;
  final bool isOverlayActive;

  // 🧱 Initial constructor with default values
  const SignInPageState({
    this.email = const EmailInputValidation.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.failure,
    this.isPasswordObscure = true,
    this.isOverlayActive = false,
  });

  // 🔁 Returns new instance with optional overridden fields
  SignInPageState copyWith({
    final EmailInputValidation? email,
    final PasswordInput? password,
    final FormzSubmissionStatus? status,
    final bool? isValid,
    final Consumable<FailureUIModel>? failure,
    final bool? isPasswordObscure,
    final bool? isOverlayActive,
  }) {
    return SignInPageState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      failure: failure ?? this.failure,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isOverlayActive: isOverlayActive ?? false,
    );
  }

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    isValid,
    failure,
    isPasswordObscure,
    isOverlayActive,
  ];

  ///
}
