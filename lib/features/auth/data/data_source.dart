import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../core/utils/typedef.dart';

/// 📜 [AuthRemoteDataSource] — contract for Firebase auth operations
abstract class AuthRemoteDataSource {
  Stream<fb_auth.User?> get user;

  ResultFuture<fb_auth.UserCredential> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<void> signOut();

  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user);
}
