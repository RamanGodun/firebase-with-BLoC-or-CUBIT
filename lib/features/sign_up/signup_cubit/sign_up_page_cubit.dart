import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:formz/formz.dart';

import '../../../../core/utils_and_services/debouncer.dart';
import '../../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../../core/utils_and_services/form_fields_validation_and_extension/forms_status_extension.dart';
import '../../../core/utils_and_services/form_fields_validation_and_extension/email_input.dart';
import '../../../core/utils_and_services/form_fields_validation_and_extension/passwords_input.dart';
import '../../../core/utils_and_services/form_fields_validation_and_extension/validation_for_name_input.dart';
import '../../../core/utils_and_services/form_fields_validation_and_extension/validation_for_password_confirmation.dart';
import '../../../../data/repositories/auth_repository.dart';

part 'sign_up_page_state.dart';

/// 🧠 [SignUpCubit] — Handles logic for sign-up form: validation, debouncing, and submission.
class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  final _debouncer = Debouncer(const Duration(milliseconds: 300));

  SignUpCubit({required this.authRepository}) : super(const SignUpState()) {
    debugPrint('🟢 onCreate -- SignUpCubit');
    resetState();
  }

  /// Handles name field change with debounce
  void onNameChanged(String value) {
    _debouncer.run(() {
      final name = NameInput.dirty(value);
      emit(state.copyWith(name: name, isValid: _validateForm(name: name)));
    });
  }

  /// Handles email field change with debounce
  void onEmailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInput.dirty(value);
      emit(state.copyWith(email: email, isValid: _validateForm(email: email)));
    });
  }

  /// Handles password field change and updates confirm password
  void onPasswordChanged(String value) {
    final password = PasswordInput.dirty(value);
    final confirm = ConfirmPasswordInput.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirm,
        isValid: _validateForm(password: password, confirmPassword: confirm),
      ),
    );
  }

  /// Handles confirm password change
  void onConfirmPasswordChanged(String value) {
    final confirm = ConfirmPasswordInput.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmPassword: confirm,
        isValid: _validateForm(confirmPassword: confirm),
      ),
    );
  }

  /// Submits sign-up form and emits appropriate state
  Future<void> submitForm() async {
    if (!state.isValid || state.status.isSubmissionInProgress) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      await authRepository.signup(
        name: state.name.value,
        email: state.email.value,
        password: state.password.value,
      );
      if (isClosed) return;
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          error: handleException(e),
        ),
      );
    }
  }

  /// Resets only submission status (e.g. after error popup)
  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  /// Fully resets sign-up form to initial state
  void resetState() {
    debugPrint('🧼 SignUpCubit → resetState()');
    emit(const SignUpState());
  }

  /// Local validation method
  bool _validateForm({
    NameInput? name,
    EmailInput? email,
    PasswordInput? password,
    ConfirmPasswordInput? confirmPassword,
  }) {
    return Formz.validate([
      name ?? state.name,
      email ?? state.email,
      password ?? state.password,
      confirmPassword ?? state.confirmPassword,
    ]);
  }

  @override
  Future<void> close() {
    debugPrint('🔴 onClose -- SignUpCubit');
    return super.close();
  }
}
