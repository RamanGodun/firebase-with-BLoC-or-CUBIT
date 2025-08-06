import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/core_utils/errors_observing/loggers/failure_logger_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/core_utils/specific_for_bloc/consumable_extensions.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/base_modules/errors_handling/core_of_module/failure_entity.dart';
import '../../../../../core/base_modules/errors_handling/core_of_module/core_utils/specific_for_bloc/consumable.dart';
import '../../../../../core/base_modules/errors_handling/core_of_module/core_utils/result_handler_async.dart';
import '../../../../../core/utils_shared/timing_control/timing_config.dart';
import '../../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../../core/base_modules/form_fields/input_validation/x_on_forms_submition_status.dart';
import '../../../../../core/base_modules/form_fields/utils/_form_validation_service.dart';
import '../../../../../core/utils_shared/timing_control/debouncer.dart';
import '../../../domain/password_actions_use_case.dart';
part 'reset_password_state.dart';

/// 🔐 [ResetPasswordCubit] — Manages reset password logic, validation, submission.
/// ✅ Leverages [PasswordRelatedUseCases] injected via DI and uses declarative state updates.
//
final class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ///--------------------------------------------
  //
  final PasswordRelatedUseCases _useCases;
  final FormValidationService _validation;
  final _debouncer = Debouncer(AppDurations.ms180);
  final _submitDebouncer = Debouncer(AppDurations.ms600);

  ResetPasswordCubit(this._useCases, this._validation)
    : super(const ResetPasswordState());

  /// 📧 Handles email field changes with debounce and validation
  void onEmailChanged(String value) {
    _debouncer.run(() {
      final email = _validation.validateEmail(value.trim());
      emit(state.updateWith(email: email));
    });
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
      final result = await _useCases.callResetPassword(state.email.value);
      if (isClosed) return;
      //
      ResultHandlerAsync(result)
        ..onSuccessAsync((_) {
          debugPrint('✅ Reset password link sent');
          emit(state._copyWith(status: FormzSubmissionStatus.success));
        })
        ..onFailureAsync((f) {
          debugPrint('❌ Reset password failed: ${f.runtimeType}');
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

  ///

  /// 🧽 Resets the failure after it’s been consumed
  void clearFailure() => emit(state._copyWith(failure: null));

  /// 🔄 Resets only the submission status (used after dialogs)
  void resetStatus() {
    emit(state._copyWith(status: FormzSubmissionStatus.initial));
  }

  /// 🧼 Cancels all pending debounce operations
  void _cancelDebouncers() {
    _debouncer.cancel(); // 🧯 prevent delayed emit from old email input
    _submitDebouncer.cancel(); // 🧯 prevent accidental double submit
  }

  /// ♻️ Resets the full state to initial
  void resetState() {
    _cancelDebouncers();
    emit(const ResetPasswordState());
  }

  /// 🧼 Cleans up resources on close
  @override
  Future<void> close() {
    _cancelDebouncers();
    return super.close();
  }

  //
}
