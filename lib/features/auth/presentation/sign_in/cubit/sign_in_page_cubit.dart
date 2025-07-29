import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/for_bloc/consumable.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/for_bloc/consumable_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../../core/base_modules/errors_handling/utils/for_bloc/result_handler_async.dart';
import '../../../../../core/base_modules/form_fields/utils/_form_validation_service.dart';
import '../../../../../core/base_modules/form_fields/input_validation/validation_enums.dart';
import '../../../../../core/utils_shared/timing_control/debouncer.dart';
import '../../../domain/use_cases/sign_in.dart';

part 'sign_in_page_state.dart';
part 'sign_in_state_validation_x.dart';

/// 🔐 [SignInCubit] — Manages Sign In logic, validation, submission.
/// ✅ Leverages via DI [SignInService] and uses DSL-like result handler.
//
final class SignInCubit extends Cubit<SignInPageState> {
  ///-----------------------------------------
  //
  final SignInUseCase _signInUseCase;
  final FormValidationService _validationService;
  final _debouncer = Debouncer(const Duration(milliseconds: 200));
  final _submitDebouncer = Debouncer(const Duration(milliseconds: 600));

  SignInCubit(this._signInUseCase, this._validationService)
    : super(const SignInPageState());

  ///

  /// 📧 Handles email field changes with debounce and validation
  void emailChanged(String value) {
    _debouncer.run(() {
      final email = _validationService.validateEmail(value.trim());
      emit(state.updateWith(email: email));
    });
  }

  /// 🔒 Handles password field changes and form revalidation
  void passwordChanged(String value) {
    final password = _validationService.validatePassword(value.trim());
    emit(state.updateWith(password: password));
  }

  /// 👁️ Toggles password visibility flag
  void togglePasswordVisibility() {
    emit(state._copyWith(isPasswordObscure: !state.isPasswordObscure));
  }

  /// 🚀 Triggers form submission via [SignInService]
  Future<void> submit() async {
    if (!state.isValid || isClosed) return;

    _submitDebouncer.run(() async {
      emit(state._copyWith(status: FormzSubmissionStatus.inProgress));

      final result = await _signInUseCase.call(
        email: state.email.value,
        password: state.password.value,
      );

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
  }
 */

  /// 🔄 Resets only the submission status (used after dialogs)
  void resetStatus() =>
      emit(state._copyWith(status: FormzSubmissionStatus.initial));

  /// 🧼 Resets the entire form to initial state
  void resetForm() {
    _debouncer.cancel(); // 🧯 prevent delayed emit from old email input
    _submitDebouncer.cancel(); // 🧯 prevent accidental double submit
    emit(const SignInPageState());
  }

  /// 🧽 Resets failure after consumption
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
