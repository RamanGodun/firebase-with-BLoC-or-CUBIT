import 'package:formz/formz.dart';
import '../../../../../core/shared_modules/form_fields/input_validation/_inputs_validation.dart';
import '../../../../../core/shared_modules/errors_handling/utils/consumable.dart';
import 'sign_up_page_cubit.dart';
import '../../../../../core/shared_modules/errors_handling/failures/_failure.dart';

/// 🧩 [SignUpStateValidationX] — Adds validation and update utilities to [SignUpState]
/// ✅ Simplifies state mutation and ensures validation is always up-to-date
/// 🔐 Used in `SignUpCubit` for field-level updates with validation
//----------------------------------------------------------------------------

extension SignUpStateValidationX on SignUpState {
  //
  /// ✅ Validates form fields using Formz
  /// 📥 Accepts optional overrides; falls back to current state values
  bool validateWith({
    NameInputValidation? name,
    EmailInputValidation? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
  }) {
    return Formz.validate([
      name ?? this.name,
      email ?? this.email,
      password ?? this.password,
      confirmPassword ?? this.confirmPassword,
    ]);
  }

  /// 🔁 Returns a new state with updated values and revalidated form
  /// 📦 Supports field updates and UI controls like visibility or submission status
  SignUpState updateWith({
    NameInputValidation? name,
    EmailInputValidation? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
    FormzSubmissionStatus? status,
    final Consumable<Failure>? failure,
    bool? isPasswordObscure,
    bool? isConfirmPasswordObscure,
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
}
