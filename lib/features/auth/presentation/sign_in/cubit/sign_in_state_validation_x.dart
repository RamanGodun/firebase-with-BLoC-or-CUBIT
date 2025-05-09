part of 'sign_in_page_cubit.dart';

/// 🧩 [SignInStateValidationX] — Adds validation and update logic to [SignInPageState]
/// ✅ Ensures clean and consistent field updates with auto-validation
/// 🔐 Used inside `SignInCubit` to simplify `emit(...)` logic
//----------------------------------------------------------------------------

extension SignInStateValidationX on SignInPageState {
  // ✅ Validates [email] and [password] fields using [Formz]
  // 📥 Accepts overrides or falls back to current state values
  bool validateWith({
    final EmailInputValidation? email,
    final PasswordInput? password,
  }) {
    return Formz.validate([email ?? this.email, password ?? this.password]);
  }

  // 🔁 Returns updated state with revalidated `isValid` flag
  // 📦 Supports field updates and additional UI flags like status & visibility
  SignInPageState updateWith({
    final EmailInputValidation? email,
    final PasswordInput? password,
    final FormzSubmissionStatus? status,
    final Consumable<FailureUIModel>? failure,
    final bool? isPasswordObscure,
  }) {
    final updated = copyWith(
      email: email,
      password: password,
      status: status,
      failure: failure,
      isPasswordObscure: isPasswordObscure,
    );
    return updated.copyWith(isValid: updated.validateWith());
  }

  ///
}
