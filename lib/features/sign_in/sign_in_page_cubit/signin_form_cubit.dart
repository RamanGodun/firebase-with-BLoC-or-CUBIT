import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import '../../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../../core/utils_and_services/form_fields_input/email_input.dart';
import '../../../core/utils_and_services/form_fields_input/passwords_input.dart';
import '../../auth/auth_repository.dart';

part 'signin_form_state.dart';

class SigninFormCubit extends Cubit<SigninFormState> {
  final AuthRepository authRepository;
  SigninFormCubit({required this.authRepository})
    : super(const SigninFormState());

  void emailChanged(String value) {
    final email = EmailInput.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = PasswordInput.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> submit() async {
    if (!state.isValid || state.status == FormzSubmissionStatus.inProgress) {
      return;
    }

    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await authRepository.signin(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
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
}
