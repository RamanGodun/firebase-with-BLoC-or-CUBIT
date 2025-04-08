import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../../data/sources/remote_firebase/firebase_constants.dart';
import '../../auth/auth_repository.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository authRepository;

  SigninCubit({required this.authRepository}) : super(SigninState.initial());

  Future<void> signin({required String email, required String password}) async {
    try {
      final credential = await fbAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
      await authRepository.ensureUserProfileCreated(user);
    } catch (e) {
      throw handleException(e);
    }
  }

  ///
}
