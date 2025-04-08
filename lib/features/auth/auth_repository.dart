import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../data/sources/remote/firebase_constants.dart' show usersCollection;

class AuthRepository {
  // comment: Actually FirebaseFirestore is not used
  final FirebaseFirestore firebaseFirestore;
  final fb_auth.FirebaseAuth firebaseAuth;
  const AuthRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final fb_auth.UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      final signedInUser = userCredential.user!;

      await usersCollection.doc(signedInUser.uid).set({
        'name': name,
        'email': email,
        'profileImage': 'https://picsum.photos/300',
        'point': 0,
        'rank': 'bronze',
      });
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

  Future<void> signin({required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
