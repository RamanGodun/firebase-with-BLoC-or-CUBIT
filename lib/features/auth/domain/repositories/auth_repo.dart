import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../../core/utils/typedef.dart';

/// 🔐 [AuthRepo] — Abstract contract for authentication-related operations
/// Defines interaction points for remote auth layer (e.g., Firebase)
//----------------------------------------------------------------

abstract interface class AuthRepo {
  /// 🔄 Stream of the currently authenticated Firebase user
  Stream<fb_auth.User?> get user;

  /// 📝 Signs up a new user with [name], [email], and [password]
  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// 🔓 Signs in an existing user using [email] and [password]
  ResultFuture<fb_auth.UserCredential> signIn({
    required String email,
    required String password,
  });

  /// 🚪 Signs out the currently logged-in user
  ResultFuture<void> signOut();

  /// ✅ Ensures the user profile exists in the database (e.g. Firestore)
  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user);

  //
}
