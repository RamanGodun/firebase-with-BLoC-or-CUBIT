import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import '../../../../core/utils_and_services/debouncer.dart';
import '../../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../../../core/utils_and_services/form_fields_input/email_input.dart';
import '../../../../core/utils_and_services/form_fields_input/passwords_input.dart';
import '../../../presentation/widgets/input_fields.dart/name_input_field.dart'
    show NameInput;
import '../../../presentation/widgets/input_fields.dart/password_confirmation_input_filed.dart'
    show ConfirmPasswordInput;
import '../../auth/auth_repository.dart';

part 'sign_up_page_state.dart';

class SignupPageCubit extends Cubit<SignupPageState> {
  final AuthRepository authRepository;
  SignupPageCubit({required this.authRepository})
    : super(const SignupPageState()) {
    print('🟢 onCreate -- SignupPageCubit');
    resetForm();
  }

  final _debouncer = Debouncer(const Duration(milliseconds: 300));

  void nameChanged(String value) {
    _debouncer.run(() {
      final name = NameInput.dirty(value);
      emit(
        state.copyWith(
          name: name,
          isValid: Formz.validate([
            name,
            state.email,
            state.password,
            state.confirmPassword,
          ]),
        ),
      );
    });
  }

  void emailChanged(String value) {
    _debouncer.run(() {
      final email = EmailInput.dirty(value);
      emit(
        state.copyWith(
          email: email,
          isValid: Formz.validate([
            state.name,
            email,
            state.password,
            state.confirmPassword,
          ]),
        ),
      );
    });
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    final confirmPassword = ConfirmPasswordInput.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );

    emit(
      state.copyWith(
        password: password,
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.name,
          state.email,
          password,
          confirmPassword,
        ]),
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword = ConfirmPasswordInput.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.password,
          confirmPassword,
        ]),
      ),
    );
  }

  Future<void> submit() async {
    if (!state.isValid || state.status == FormzSubmissionStatus.inProgress) {
      return;
    }

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

  void resetStatus() {
    emit(state.copyWith(status: FormzSubmissionStatus.initial));
  }

  void resetForm() {
    print('🧼 SignupPageCubit -> resetForm() called');
    emit(const SignupPageState());
  }

  @override
  Future<void> close() {
    print('🔴 onClose -- SignupPageCubit');
    return super.close();
  }
}
