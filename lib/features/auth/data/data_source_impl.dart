import 'package:flutter/foundation.dart' show debugPrint;

import '../../../app_bootstrap_and_config/app_configs/firebase/data_source_constants.dart';
import '../../../core/utils_shared/auth_state/auth_user_utils.dart';
import 'data_source_contract.dart';

/// 🛠️ [AuthRemoteDatabaseImpl] — Firebase-powered remote data source.
/// ✅ Implements low-level Firebase logic only.
//
final class AuthRemoteDatabaseImpl implements IAuthRemoteDatabase {
  ///---------------------------------------------------------------
  //
  /// 🔐 Firebase sign-in
  @override
  Future<void> signIn({required String email, required String password}) async {
    await FirebaseConstants.fbAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// 🆕 Firebase sign-up
  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    final cred = await FirebaseConstants.fbAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
     sendVerificationEmail();
    // Return UID only (to stay generic)
    return cred.user?.uid ?? '';
  }

  /// 📧 Sends email verification to the current user
  Future<void> sendVerificationEmail() async {
    final user = AuthUserUtils.currentUserOrThrow;
    debugPrint('Sending verification email to: ${user.email}');
    await user.sendEmailVerification();
    debugPrint('Verification email sent!');
  }

  /// 💾 Save User in Firestore
  @override
  Future<void> saveUserData(String uid, Map<String, dynamic> userData) async {
    await FirebaseConstants.usersCollection.doc(uid).set(userData);
  }

  /// 🔓 Firebase sign-out
  @override
  Future<void> signOut() async {
    await FirebaseConstants.fbAuth.signOut();
  }

  //
}
