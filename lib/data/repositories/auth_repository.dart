import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../core/constants/app_constants.dart' show AppConstants;
import '../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../data_transfer_objects/user_dto.dart';

/// 🧩 [AuthRepository]
/// Handles all authentication-related logic:
///    - 🔐 Sign in / sign up
///    - 🧾 User stream
///    - ☁️ Firestore profile initialization
///    - 🚪 Sign out

class AuthRepository {
  final FirebaseFirestore firestore;
  final fb_auth.FirebaseAuth firebaseAuth;

  const AuthRepository({required this.firestore, required this.firebaseAuth});

  /// 🔁 Emits current [fb_auth.User] changes
  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  /// 👤 Registers new user and stores Firestore profile
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

      await firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(userDto.toMap());
    } catch (e) {
      throw handleException(e);
    }
  }

  /// ☁️ Ensures user profile exists in Firestore after login/signup
  Future<void> ensureUserProfileCreated(fb_auth.User user) async {
    try {
      final doc =
          await firestore
              .collection(AppConstants.usersCollection)
              .doc(user.uid)
              .get();

      if (!doc.exists) {
        final userDto = UserDto.newUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await firestore
            .collection(AppConstants.usersCollection)
            .doc(user.uid)
            .set(userDto.toMap());
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 🔐 Sign in with email/password
  Future<fb_auth.UserCredential> signin({
    required String email,
    required String password,
  }) async {
    try {
      return await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 🚪 Sign out user from FirebaseAuth
  Future<void> signout() async {
    await firebaseAuth.signOut();
  }
}
