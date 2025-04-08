import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/form_fields_input/forms_status_extension.dart';
import 'package:formz/formz.dart';
import '../../../../core/utils_and_services/debouncer.dart';
import '../../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../../../core/utils_and_services/form_fields_input/email_input.dart';
import '../../../../core/utils_and_services/form_fields_input/passwords_input.dart';
import '../../auth/auth_repository.dart';
import '../../../core/utils_and_services/errors_handling/custom_validation_of_input_fields/validation_for_name_input.dart';
import '../../../core/utils_and_services/errors_handling/custom_validation_of_input_fields/validation_for_password_confirmation.dart';

part 'sign_up_page_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository authRepository;
  final _debouncer = Debouncer(const Duration(milliseconds: 300));

  SignUpCubit({required this.authRepository}) : super(const SignUpState()) {
    print('🟢 onCreate -- SignUpCubit');
    resetState();
  }

  /// Handle name field change
  void onNameChanged(String value) {
    _debouncer.run(() {
      final name = NameInput.dirty(value);
      emit(state.copyWith(name: name, isValid: _validateForm(name: name)));
    });
  }

  /// Handle email field change
  void onEmailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInput.dirty(value);
      emit(state.copyWith(isValid: _validateForm(email: email)));
    });
  }

  /// Handle password field change
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

  /// Handle confirm password change
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

  /// Submit sign-up form
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

  /// Reset only submission status
  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  /// Reset whole form state
  void resetState() {
    print('🧼 SignUpCubit → resetState()');
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
    print('🔴 onClose -- SignUpCubit');
    return super.close();
  }
}
