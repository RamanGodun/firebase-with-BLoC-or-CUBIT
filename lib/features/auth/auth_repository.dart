import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils_and_services/errors_handling/handle_exception.dart';

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
      await firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': email,
        'profileImage': 'https://picsum.photos/300',
        'point': 0,
        'rank': 'bronze',
      });
    } catch (e) {
      throw handleException(e);
    }
  }

  ///
  Future<void> ensureUserProfileCreated(fb_auth.User user) async {
    try {
      final doc = await firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        await firestore.collection('users').doc(user.uid).set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'profileImage': 'https://picsum.photos/300',
          'point': 0,
          'rank': 'bronze',
        });
      }
    } catch (e) {
      throw handleException(e);
    }
  }

  /// 🔐 Signs in the user with email/password credentials.
  // Future<void> signin({required String email, required String password}) async {
  //   try {
  //     await firebaseAuth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //   } catch (e) {
  //     throw handleException(e);
  //   }
  // }
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
