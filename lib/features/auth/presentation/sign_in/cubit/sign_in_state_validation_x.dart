import 'package:formz/formz.dart';
import '../../../../../core/shared_modules/errors_handling/failures/failure_ui_model.dart';
import '../../../../../core/shared_modules/form_fields/input_validation/_inputs_validation.dart';
import '../../../../../core/shared_modules/errors_handling/utils/consumable.dart';
import 'sign_in_page_cubit.dart';

/// 🧩 [SignInStateValidationX] — Adds validation and update logic to [SignInPageState]
/// ✅ Ensures clean and consistent field updates with auto-validation
/// 🔐 Used inside `SignInCubit` to simplify `emit(...)` logic
//----------------------------------------------------------------------------

extension SignInStateValidationX on SignInPageState {
  /// ✅ Validates [email] and [password] fields using [Formz]
  /// 📥 Accepts overrides or falls back to current state values
  bool validateWith({EmailInputValidation? email, PasswordInput? password}) {
    return Formz.validate([email ?? this.email, password ?? this.password]);
  }

  /// 🔁 Returns updated state with revalidated `isValid` flag
  /// 📦 Supports field updates and additional UI flags like status & visibility
  SignInPageState updateWith({
    EmailInputValidation? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    Consumable<FailureUIModel>? failure,
    bool? isPasswordObscure,
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
