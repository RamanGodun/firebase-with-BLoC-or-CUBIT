import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/to_ui_failures_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/utils/consumable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/shared_modules/errors_handling/failures/failure_ui_entity.dart';
import '../../../../../core/shared_modules/errors_handling/utils/dsl_result_handler_async.dart';
import '../../../../form_fields/input_validation/_inputs_validation.dart';
import '../../services/sign_in_service.dart';
import '../../../../../core/general_utils/debouncer.dart';

part 'sign_in_page_state.dart';
part 'sign_in_state_validation_x.dart';

/// 🔐 [SignInCubit] — Manages Sign In logic, validation, submission.
/// ✅ Leverages via DI [SignInService] and uses DSL-like result handler.
//----------------------------------------------------------------------------

class SignInCubit extends Cubit<SignInPageState> {
  //
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

    ResultHandlerAsync(result)
      ..onFailureAsync((f) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            failure: f.asConsumableUIEntity(),
          ),
        );
      })
      ..onSuccessAsync((_) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      })
      ..logAsync();
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
      emit(state.copyWith(status: FormzSubmissionStatus.initial));

  /// 🧼 Resets the entire form to initial state
  void resetForm() => emit(const SignInPageState());

  /// 🧽 Resets failure after consumption
  void clearFailure() => emit(state.copyWith(failure: null));

  ///
}
