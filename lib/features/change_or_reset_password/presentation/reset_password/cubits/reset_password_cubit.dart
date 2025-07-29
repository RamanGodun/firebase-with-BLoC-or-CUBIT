import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
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
part 'reset_password_state.dart';

final class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ///--------------------------------------------
  //
  final PasswordRelatedUseCases _useCases;
  final FormValidationService _validation;
  final _debouncer = Debouncer(const Duration(milliseconds: 200));
  final _submitDebouncer = Debouncer(const Duration(milliseconds: 600));

  ResetPasswordCubit(this._useCases, this._validation)
    : super(const ResetPasswordState());

  /// 📧 Handles email input with debounce
  void onEmailChanged(String value) {
    _debouncer.run(() {
      final email = _validation.validateEmail(value.trim());
      emit(state.updateWith(email: email));
    });
  }

  /// 🚀 Submits reset password request if valid
  Future<void> submit() async {
    if (!state.isValid || isClosed || state.status.isSubmissionInProgress) {
      return;
    }

    _submitDebouncer.run(() async {
      emit(state._copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _useCases.callResetPassword(state.email.value);

      if (isClosed) return;

      ResultHandlerAsync(result)
        ..onFailureAsync((f) {
          emit(
            state._copyWith(
              status: FormzSubmissionStatus.failure,
              failure: f.asConsumable(),
            ),
          );
          f.log();
        })
        ..onSuccessAsync((_) {
          emit(state._copyWith(status: FormzSubmissionStatus.success));
        })
        ..logAsync();
    });
  }

  /// ♻️ Resets only submission status (e.g. after dialog)
  void resetStatus() {
    emit(state._copyWith(status: FormzSubmissionStatus.initial));
  }

  /// 🧽 Resets the failure after it’s been consumed
  void clearFailure() => emit(state._copyWith(failure: null));

  /// 🧼 Fully resets form state
  void resetState() {
    _debouncer.cancel();
    _submitDebouncer.cancel();
    emit(const ResetPasswordState());
  }
}
