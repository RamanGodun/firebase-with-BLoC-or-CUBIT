import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/shared_modules/errors_handling/failure.dart';
import '../../../../../core/shared_modules/form_fields/forms_status_extension.dart';
import '../../../../../core/shared_modules/form_fields/email_input.dart';
import '../../../../../core/shared_modules/form_fields/passwords_input.dart';
import '../../../../../core/shared_modules/form_fields/validation_for_name_input.dart';
import '../../../../../core/shared_modules/form_fields/validation_for_password_confirmation.dart';
import '../../../../../core/shared_modules/errors_handling/result_handler.dart';
import '../../../domain/use_cases/sign_up.dart';

part 'sign_up_page_state.dart';

/// 🧠 [SignUpCubit] — Handles logic for sign-up form: validation, debouncing, and submission.
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;
  final _debouncer = Debouncer(const Duration(milliseconds: 300));

  SignUpCubit({required this.signUpUseCase}) : super(const SignUpState());

  void onNameChanged(String value) {
    _debouncer.run(() {
      final name = NameInput.dirty(value);
      emit(state.copyWith(name: name, isValid: _validateForm(name: name)));
    });
  }

  void onEmailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInput.dirty(value);
      emit(state.copyWith(email: email, isValid: _validateForm(email: email)));
    });
  }

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

  Future<void> submitForm() async {
    if (!state.isValid || state.status.isSubmissionInProgress) return;

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await signUpUseCase.call(
      name: state.name.value,
      email: state.email.value,
      password: state.password.value,
    );

    ResultHandler(result)
        .onFailure(
          (f) => emit(
            state.copyWith(status: FormzSubmissionStatus.failure, failure: f),
          ),
        )
        .onSuccess((_) {
          if (isClosed) return;
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        })
        .log();
  }

  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void resetState() {
    debugPrint('🧼 SignUpCubit → resetState()');
    emit(const SignUpState());
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

  @override
  Future<void> close() {
    debugPrint('🔴 onClose -- SignUpCubit');
    return super.close();
  }
}
