import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import '../../../../../core/utils_and_services/debouncer.dart';
import '../../../../../core/utils_and_services/errors_handling/failure.dart';
import '../../form_fields/email_input.dart';
import '../../form_fields/passwords_input.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../../core/utils_and_services/errors_handling/result_handler.dart';

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

    final result = await authRepository.signin(
      email: state.email.value,
      password: state.password.value,
    );

    ResultHandler<fb_auth.UserCredential>(result)
        .onFailure(
          (f) => emit(
            state.copyWith(status: FormzSubmissionStatus.failure, failure: f),
          ),
        )
        .onSuccess((credential) async {
          final user = credential.user;
          if (user == null) {
            emit(
              state.copyWith(
                status: FormzSubmissionStatus.failure,
                failure: const UnknownFailure(message: 'User is null'),
              ),
            );
            return;
          }

          final profileResult = await authRepository.ensureUserProfileCreated(
            user,
          );
          ResultHandler(profileResult)
              .onFailure(
                (f) => emit(
                  state.copyWith(
                    status: FormzSubmissionStatus.failure,
                    failure: f,
                  ),
                ),
              )
              .onSuccess((_) {
                if (isClosed) return;
                emit(state.copyWith(status: FormzSubmissionStatus.success));
              })
              .log();
        })
        .log();
  }

  void resetStatus() =>
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
  void resetForm() => emit(const SignInPageState());

  @override
  Future<void> close() {
    debugPrint('🔴 onClose -- SignInCubit');
    return super.close();
  }
}
