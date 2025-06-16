part of 'sign_up_page_cubit.dart';

/// 🥉 [SignUpStateValidationX] — Adds validation and update utilities to [SignUpState]
/// ✅ Simplifies state mutation and ensures validation is always up-to-date
/// 🔐 Used in `SignUpCubit` for field-level updates with validation

extension SignUpStateValidationX on SignUpState {
  //--------------------------------------------

  /// ✅ Validates form fields using Formz
  /// 📅 Accepts optional overrides; falls back to current state values
  bool validateWith({
    final NameInputValidation? name,
    final EmailInputValidation? email,
    final PasswordInput? password,
    final ConfirmPasswordInput? confirmPassword,
  }) {
    return Formz.validate([
      name ?? this.name,
      email ?? this.email,
      password ?? this.password,
      confirmPassword ?? this.confirmPassword,
    ]);
  }

  /// ➞ Returns a new state with updated values and revalidated form
  /// 📦 Supports field updates and UI controls like visibility or submission status
  SignUpState updateWith({
    final NameInputValidation? name,
    final EmailInputValidation? email,
    final PasswordInput? password,
    final ConfirmPasswordInput? confirmPassword,
    final FormzSubmissionStatus? status,
    final Consumable<FailureUIEntity>? failure,
    final bool? isPasswordObscure,
    final bool? isConfirmPasswordObscure,
  }) {
    final updated = copyWith(
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      status: status,
      failure: failure,
      isPasswordObscure: isPasswordObscure,
      isConfirmPasswordObscure: isConfirmPasswordObscure,
    );
    return updated.copyWith(isValid: updated.validateWith());
  }

  //
}
