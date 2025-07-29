part of 'sign_in_page_cubit.dart';

/// 📄 [SignInPageState] — Stores form field values and validation status
/// ✅ Used by [SignInCubit] to manage UI state reactively
//
final class SignInPageState extends Equatable {
  ///---------------------------------------
  //
  final EmailInputValidation email;
  final PasswordInputValidation password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final Consumable<Failure>? failure;
  final bool isPasswordObscure;

  // 🧱 Initial constructor with default values
  const SignInPageState({
    this.email = const EmailInputValidation.pure(),
    this.password = const PasswordInputValidation.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.failure,
    this.isPasswordObscure = true,
  });
  //

  // 🔁 Returns new instance with optional overridden fields
  // ⚠️ Use only inside `updateWith(...)` to ensure validation is re-applied!
  SignInPageState _copyWith({
    final EmailInputValidation? email,
    final PasswordInputValidation? password,
    final FormzSubmissionStatus? status,
    final bool? isValid,
    final Consumable<Failure>? failure,
    final bool? isPasswordObscure,
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

  @override
  List<Object?> get props => [
    email,
    password,
    status,
    isValid,
    failure,
    isPasswordObscure,
  ];

  //
}

////
////

/// 🧩 [SignInStateValidationX] — Adds validation and update logic to [SignInPageState]
/// ✅ Ensures clean and consistent field updates with auto-validation
/// 🔐 Used inside `SignInCubit` to simplify `emit(...)` logic
//
extension SignInStateValidationX on SignInPageState {
  ///----------------------------------------------
  //
  // ✅ Validates [email] and [password] fields using [Formz]
  // 📥 Accepts overrides or falls back to current state values
  bool validateWith({
    final EmailInputValidation? email,
    final PasswordInputValidation? password,
  }) {
    return Formz.validate([email ?? this.email, password ?? this.password]);
  }

  // 🔁 Returns updated state with revalidated `isValid` flag
  // 📦 Supports field updates and additional UI flags like status & visibility
  SignInPageState updateWith({
    final EmailInputValidation? email,
    final PasswordInputValidation? password,
    final FormzSubmissionStatus? status,
    final Consumable<Failure>? failure,
    final bool? isPasswordObscure,
  }) {
    final updated = _copyWith(
      email: email,
      password: password,
      status: status,
      failure: failure,
      isPasswordObscure: isPasswordObscure,
    );
    return updated._copyWith(isValid: updated.validateWith());
  }

  //
}
