import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/to_ui_failures_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/utils/for_bloc/consumable.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/shared_modules/errors_handling/failures/failure_ui_entity.dart';
import '../../../../../core/shared_modules/errors_handling/utils/for_bloc/result_handler_async.dart';
import '../../../../form_fields/input_validation/_inputs_validation.dart';
import '../../services/sign_up_service.dart';
import '../../../../../core/general_utils/timing_control/debouncer.dart';
import '../../../../form_fields/extensions/formz_status_x.dart';

part 'sign_up_page_state.dart';
part 'sign_up_state_validation_x.dart';

/// 🧠 [SignUpCubit] — Handles logic for sign-up form: validation, debouncing, and submission.
/// ✅ Delegates actual sign-up to [SignUpService]

final class SignUpCubit extends Cubit<SignUpState> {
  //-----------------------------------------------

  final SignUpService _signUpService;
  // ⏱️ Debounce short delays for inputs (e.g., email, name)
  final _debouncer = Debouncer(const Duration(milliseconds: 200));
  // ⏱️ Debounce submission to prevent spam-tapping
  final _submitDebouncer = Debouncer(const Duration(milliseconds: 600));

  SignUpCubit(this._signUpService) : super(const SignUpState());

  /// 👤 Handles name input with trimming & debounce
  void onNameChanged(String value) {
    _debouncer.run(() {
      final input = NameInputValidation.dirty(value.trim());
      emit(state.updateWith(name: input));
    });
  }

  /// 📧 Handles email input with debounce
  void onEmailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInputValidation.dirty(value);
      emit(state.updateWith(email: email));
    });
  }

  /// 🔒 Handles password input and updates confirm sync
  void onPasswordChanged(String value) {
    final password = PasswordInput.dirty(value);
    final confirm = state.confirmPassword.updatePassword(password.value);
    emit(state.updateWith(password: password, confirmPassword: confirm));
  }

  /// 🔐 Handles confirm password input and validates match
  void onConfirmPasswordChanged(String value) {
    final input = ConfirmPasswordInput.dirty(
      password: state.password.value,
      value: value,
    );
    emit(state.updateWith(confirmPassword: input));
  }

  /// 👁️ Toggles password field visibility
  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  /// 👁️🔁 Toggles confirm password visibility
  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordObscure: !state.isConfirmPasswordObscure),
    );
  }

  /// 🚀 Triggers sign-up process (via [SignUpService]), if form is valid
  Future<void> submit() async {
    if (!state.isValid || isClosed || state.status.isSubmissionInProgress) {
      return;
    }

    _submitDebouncer.run(() async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _signUpService.execute(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
      );

      if (isClosed) return;

      ResultHandlerAsync(result)
        ..onFailureAsync((f) {
          emit(
            state.copyWith(
              status: FormzSubmissionStatus.failure,
              failure: f.asConsumableUIEntity(),
            ),
          );
          f.log();
        })
        ..onSuccessAsync((_) {
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        })
        ..logAsync();
    });

    /*
  ? Alternative syntax: classic fold version for direct mapping:
  result.fold(
    (f) => emit(
      state.copyWith(
        status: FormzSubmissionStatus.failure,
        failure: f.asConsumableUIModel(),
      ),
    ),
    (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
  );
  */

    ///
  }

  /// ♻️ Resets only submission status (e.g. after dialog)
  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  /// 🧼 Fully resets form fields & validation
  void resetState() {
    debugPrint('🧼 SignUpCubit → resetState()');
    _debouncer.cancel();
    _submitDebouncer.cancel();
    emit(const SignUpState());
  }

  /// 🧽 Resets the failure after it’s been consumed
  void clearFailure() => emit(state.copyWith(failure: null));

  //
}
