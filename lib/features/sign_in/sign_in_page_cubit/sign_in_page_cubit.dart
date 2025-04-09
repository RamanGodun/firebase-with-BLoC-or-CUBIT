import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';

import '../../../../core/utils_and_services/debouncer.dart';
import '../../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../../../core/utils_and_services/form_fields_validation/email_input.dart';
import '../../../../core/utils_and_services/form_fields_validation/passwords_input.dart';
import '../../../../data/repositories/auth_repository.dart';

part 'sign_in_page_state.dart';

/// 🔐 [SignInCubit] — Manages Sign In logic, validation, submission.
class SignInCubit extends Cubit<SignInPageState> {
  final AuthRepository authRepository;
  final _debouncer = Debouncer(const Duration(milliseconds: 300));

  SignInCubit({required this.authRepository}) : super(const SignInPageState()) {
    debugPrint('🟢 onCreate -- SignInCubit');
    resetForm();
  }

  /// Handles email changes with debounce
  void emailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInput.dirty(value);
      emit(
        state.copyWith(
          email: email,
          isValid: Formz.validate([email, state.password]),
        ),
      );
    });
  }

  /// Handles password change and form revalidation
  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  /// Triggers async sign-in process
  Future<void> submit() async {
    if (!state.isValid || state.status == FormzSubmissionStatus.inProgress) {
      return;
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final credential = await authRepository.signin(
        email: state.email.value,
        password: state.password.value,
      );

      final user = credential.user!;
      await authRepository.ensureUserProfileCreated(user);
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

  ///
  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  ///
  void resetForm() {
    emit(const SignInPageState());
  }

  ///
  @override
  Future<void> close() {
    debugPrint('🔴 onClose -- SignInCubit');
    return super.close();
  }
}
