import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../core/shared_modules/form_fields/validation/password_input.dart';
import '../../../services/sign_up_service.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/shared_modules/errors_handling/failure.dart';
import '../../../../../core/shared_modules/form_fields/extensions/formz_status_x.dart';
import '../../../../../core/shared_modules/form_fields/validation/email_input.dart';
import '../../../../../core/shared_modules/form_fields/validation/name_input.dart';
import '../../../../../core/shared_modules/form_fields/validation/confirm_password.dart';

part 'sign_up_page_state.dart';

/// 🧠 [SignUpCubit] — Handles logic for sign-up form: validation, debouncing, and submission.
/// 🧼 Delegates sign-up execution to [SignUpService]
//----------------------------------------------------------------//
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpService _signUpService;
  final _debouncer = Debouncer(const Duration(milliseconds: 300));

  SignUpCubit(this._signUpService) : super(const SignUpState());

  /// 👤 Name change handler (with debounce)
  void onNameChanged(String value) {
    _debouncer.run(() => _updateName(NameInput.dirty(value)));
  }

  /// 📧 Email change handler (with debounce)
  void onEmailChanged(String value) {
    _debouncer.run(() => _updateEmail(EmailInput.dirty(value)));
  }

  /// 🔒 Password change
  void onPasswordChanged(String value) {
    _updatePassword(PasswordInput.dirty(value));
  }

  /// 🔐 Confirm password change
  void onConfirmPasswordChanged(String value) {
    _updateConfirmPassword(
      ConfirmPasswordInput.dirty(password: state.password.value, value: value),
    );
  }

  /// 🚀 Triggers async sign-up via [SignUpService]
  Future<void> submit() async {
    if (!state.isValid || state.status.isSubmissionInProgress) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _signUpService.execute(
      name: state.name.value,
      email: state.email.value,
      password: state.password.value,
    );

    if (isClosed) return;

    result.fold(
      (f) => emit(
        state.copyWith(status: FormzSubmissionStatus.failure, failure: f),
      ),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }

  /// 🧽 Resets only status field
  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  /// 🔄 Resets full state (all fields)
  void resetState() {
    debugPrint('🧼 SignUpCubit → resetState()');
    emit(const SignUpState());
  }

  /// Private methods are next:
  //
  void _updateEmail(EmailInput email) {
    emit(state.copyWith(email: email, isValid: _validateForm(email: email)));
  }

  void _updateName(NameInput name) {
    emit(state.copyWith(name: name, isValid: _validateForm(name: name)));
  }

  void _updatePassword(PasswordInput password) {
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

  void _updateConfirmPassword(ConfirmPasswordInput confirm) {
    emit(
      state.copyWith(
        confirmPassword: confirm,
        isValid: _validateForm(confirmPassword: confirm),
      ),
    );
  }

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

  ///
}
