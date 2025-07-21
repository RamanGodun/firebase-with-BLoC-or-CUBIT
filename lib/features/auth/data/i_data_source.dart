import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../core/utils_shared/typedef.dart';

/// 📜 [AuthRemoteDataSource] — contract for Firebase auth operations
//
abstract interface class AuthRemoteDataSource {
  ///---------------------------------------
  //
  /// 📡 Stream of authentication user changes
  Stream<fb_auth.User?> get user;

  /// 🔐 Sign in with email & password
  ResultFuture<fb_auth.UserCredential> signIn({
    required String email,
    required String password,
  });

  /// 📝 Register a new user and create their Firestore profile
  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// 🚪 Sign out current user
  ResultFuture<void> signOut();

  /// 🧱 Ensure profile exists in Firestore after sign in/up
  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user);

  //
}
