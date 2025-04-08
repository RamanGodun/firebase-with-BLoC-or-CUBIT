import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../data/sources/remote/firebase_constants.dart';
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
      final userDoc = await usersCollection.doc(user.uid).get();

      if (!userDoc.exists) {
        await usersCollection.doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'profileImage': 'https://picsum.photos/300',
          'point': 0,
          'rank': 'bronze',
        });
      }
    } on fb_auth.FirebaseAuthException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  ///
}
