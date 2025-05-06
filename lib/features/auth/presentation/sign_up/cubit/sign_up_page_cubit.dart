import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/shared_modules/form_fields/input_validation/_inputs_validation.dart';
import '../../../services/sign_up_service.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/shared_modules/errors_handling/failure.dart';
import '../../../../../core/shared_modules/form_fields/extensions/formz_status_x.dart';

part 'sign_up_page_state.dart';

/// 🧠 [SignUpCubit] — Handles logic for sign-up form: validation, debouncing, and submission.
/// ✅ Delegates actual sign-up to [SignUpService]
//----------------------------------------------------------------

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpService _signUpService;
  final _debouncer = Debouncer(const Duration(milliseconds: 300));
  SignUpCubit(this._signUpService) : super(const SignUpState());

  /// 👤 Handles name input with trimming & debounce
  void onNameChanged(String value) {
    _debouncer.run(() {
      final trimmed = value.trim();
      final input = NameInputValidation.dirty(trimmed);
      _updateName(input);
    });
  }

  /// 📧 Handles email input with debounce
  void onEmailChanged(String value) {
    _debouncer.run(() => _updateEmail(EmailInputValidation.dirty(value)));
  }

  /// 🔒 Handles password input and triggers confirm sync
  void onPasswordChanged(String value) {
    _updatePassword(PasswordInput.dirty(value));
  }

  /// 🔐 Handles confirm password input and validates match
  void onConfirmPasswordChanged(String value) {
    _updateConfirmPassword(
      ConfirmPasswordInput.dirty(password: state.password.value, value: value),
    );
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

  /// 🔄 Resets only submission status (e.g. after dialog)
  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  /// 🧼 Fully resets form fields & validation
  void resetState() {
    debugPrint('🧼 SignUpCubit → resetState()');
    emit(const SignUpState());
  }

  //────────────────────────────────────────────────────────────────────────────
  // 🔒 PRIVATE HELPERS
  //────────────────────────────────────────────────────────────────────────────

  void _updateEmail(EmailInputValidation email) {
    emit(state.copyWith(email: email, isValid: _validateForm(email: email)));
  }

  void _updateName(NameInputValidation name) {
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
    NameInputValidation? name,
    EmailInputValidation? email,
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
