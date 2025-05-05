import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../core/shared_modules/form_fields/validation/_inputs_validation.dart';
import '../../../services/sign_in_service.dart';
import '../../../../../core/utils/debouncer.dart';
import '../../../../../core/shared_modules/errors_handling/failure.dart';

part 'sign_in_page_state.dart';

/// 🔐 [SignInCubit] — Manages Sign In logic, validation, submission.
/// ✅ Full sign-in logic moved to [SignInService] via DI
class SignInCubit extends Cubit<SignInPageState> {
  final SignInService _signInService;
  final _debouncer = Debouncer(const Duration(milliseconds: 300));

  SignInCubit(this._signInService) : super(const SignInPageState());

  /// 📧 Handles email changes with debounce
  void emailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInputValidation.dirty(value);
      emit(
        state.copyWith(
          email: email,
          isValid: Formz.validate([email, state.password]),
        ),
      );
    });
  }

  /// 🔐 Handles password change and form revalidation
  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  /// 🚀 Triggers async sign-in via [SignInService]
  Future<void> submit() async {
    if (!state.isValid || isClosed) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    final result = await _signInService.execute(
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

  void resetStatus() =>
      emit(state.copyWith(status: FormzSubmissionStatus.initial));
  void resetForm() => emit(const SignInPageState());

  ///
}
