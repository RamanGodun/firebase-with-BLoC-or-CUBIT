import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/consumable.dart';
import 'package:firebase_with_bloc_or_cubit/features/auth/presentation/sign_in/cubit/sign_in_state_validation_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/shared_modules/form_fields/input_validation/_inputs_validation.dart';
import '../../../sign_up_utils/sign_in_service.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/shared_modules/errors_handling/failures/failure.dart';
part 'sign_in_page_state.dart';

/// 🔐 [SignInCubit] — Manages Sign In logic, validation, submission.
/// ✅ Full sign-in logic moved to [SignInService] via DI
//----------------------------------------------------------------

class SignInCubit extends Cubit<SignInPageState> {
  final SignInService _signInService;
  final _debouncer = Debouncer(const Duration(milliseconds: 200));

  SignInCubit(this._signInService) : super(const SignInPageState());

  /// 📧 Handles email field changes with debounce and validation
  void emailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInputValidation.dirty(value);
      emit(state.updateWith(email: email));
    });
  }

  /// 🔒 Handles password field changes and form revalidation
  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    emit(state.updateWith(password: password));
  }

  /// 👁️ Toggles password visibility flag
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  /// 🚀 Triggers form submission via [SignInService]
  Future<void> submit() async {
    if (!state.isValid || isClosed) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _signInService.execute(
      email: state.email.value,
      password: state.password.value,
    );

    if (isClosed) return;

    result.fold(
      (f) => emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          failure: f.asConsumable(),
        ),
      ),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }

  /// 🔄 Resets only the submission status (used after dialogs)
  void resetStatus() =>
      emit(state.copyWith(status: FormzSubmissionStatus.initial));

  /// 🧼 Resets the entire form to initial state
  void resetForm() => emit(const SignInPageState());

  /// 🧽 Resets failure after consumption (якщо окремо від статусу)
  void clearFailure() => emit(state.copyWith(failure: null));

  ///
}
