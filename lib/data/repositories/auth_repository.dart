import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../data_transfer_objects/user_dto.dart';
import '../sources/remote_firebase/firebase_constants.dart';

/// **Repository for Authentication-related logic**
///
/// Provides `signup`, `signin`, `signout` and `user` stream access.
/// Delegates error handling to [handleException] for consistency.
class AuthRepository {
  final FirebaseFirestore firestore;
  final fb_auth.FirebaseAuth firebaseAuth;

  const AuthRepository({required this.firestore, required this.firebaseAuth});

  /// 🔁 Returns a stream of the currently authenticated [fb_auth.User]
  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  /// 👤 Creates a new user account and initializes Firestore profile.
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
      final userDto = UserDto.newUser(id: user.uid, name: name, email: email);

      await usersCollection.doc(user.uid).set(userDto.toMap());
    } catch (e) {
      throw handleException(e);
    }
  }

  ///
  Future<void> ensureUserProfileCreated(fb_auth.User user) async {
    try {
      final doc = await usersCollection.doc(user.uid).get();

      if (!doc.exists) {
        final userDto = UserDto.newUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await usersCollection.doc(user.uid).set(userDto.toMap());
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 🔐 Signs in the user with email/password credentials.
  Future<fb_auth.UserCredential> signin({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 🚪 Signs out the currently authenticated user.
  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
