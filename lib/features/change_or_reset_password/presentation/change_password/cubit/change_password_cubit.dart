import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../../core/base_modules/form_fields/input_validation/formz_status_x.dart';
import '../../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../../core/base_modules/errors_handling/utils/for_bloc/result_handler_async.dart';
import '../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable.dart';
import '../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable_x.dart';
import '../../../../../core/base_modules/form_fields/utils/_form_validation_service.dart';
import '../../../../../core/utils_shared/timing_control/debouncer.dart';
import '../../../domain/password_actions_use_case.dart';
part 'change_password_state.dart';

/// 🔐 [ChangePasswordCubit] — Manages reset password logic, validation, submission.
/// ✅ Leverages [PasswordRelatedUseCases] injected via DI and uses declarative state updates.
//
final class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ///--------------------------------------------
  //
  final PasswordRelatedUseCases _useCases;
  final FormValidationService _validation;
  final _debouncer = Debouncer(const Duration(milliseconds: 200));
  final _submitDebouncer = Debouncer(const Duration(milliseconds: 600));

  ChangePasswordCubit(this._useCases, this._validation)
    : super(const ChangePasswordState());

  /// 🔒 Handles password input and updates confirm sync
  void onPasswordChanged(String value) {
    final password = _validation.validatePassword(value.trim());
    final confirm = state.confirmPassword.updatePassword(password.value);
    emit(state.updateWith(password: password, confirmPassword: confirm));
  }

  /// 🔐 Handles confirm password input and validates match
  void onConfirmPasswordChanged(String value) {
    final input = _validation.validateConfirmPassword(
      password: state.password.value,
      value: value,
    );
    emit(state.updateWith(confirmPassword: input));
  }

  ///

  /// 🚀 Submits reset password request if form is valid
  Future<void> submit() async {
    if (!state.isValid || isClosed || state.status.isSubmissionInProgress) {
      return;
    }
    //
    _submitDebouncer.run(() async {
      emit(state._copyWith(status: FormzSubmissionStatus.inProgress));
      //
      final result = await _useCases.callChangePassword(
        state.confirmPassword.value,
      );
      if (isClosed) return;
      //
      ResultHandlerAsync(result)
        ..onSuccessAsync((_) {
          debugPrint('✅ Password changed successfully');
          emit(state._copyWith(status: FormzSubmissionStatus.success));
        })
        ..onFailureAsync((f) {
          debugPrint('❌ Password change failed: ${f.runtimeType}');
          emit(
            state._copyWith(
              status: FormzSubmissionStatus.failure,
              failure: f.asConsumable(),
            ),
          );
          f.log();
        })
        ..logAsync();
    });
  }

  /// 👁️ Toggles password field visibility
  void togglePasswordVisibility() {
    emit(state._copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  /// 👁️🔁 Toggles confirm password visibility
  void toggleConfirmPasswordVisibility() {
    emit(
      state._copyWith(
        isConfirmPasswordObscure: !state.isConfirmPasswordObscure,
      ),
    );
  }

  ///

  /// 🔄 Resets only the submission status (used after dialogs)
  void resetStatus() {
    emit(state._copyWith(status: FormzSubmissionStatus.initial));
  }

  /// 🧼 Resets the entire form to initial state
  void resetState() {
    _debouncer.cancel();
    _submitDebouncer.cancel();
    emit(const ChangePasswordState());
  }

  /// 🧽 Resets the failure after it’s been consumed
  void clearFailure() => emit(state._copyWith(failure: null));

  ///
  @override
  Future<void> close() {
    _debouncer.cancel();
    _submitDebouncer.cancel();
    return super.close();
  }

  //
}
