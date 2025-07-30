import '../../../app_bootstrap_and_config/firebase_config/firebase_constants.dart';
import '../../../app_bootstrap_and_config/firebase_config/auth_user_utils.dart';
import 'remote_database_contract.dart';

/// 🧩 [PasswordRemoteDatabaseImpl] — Firebase-based implementation of [IPasswordRemoteDatabase]
/// ✅ Handles actual communication with [FirebaseAuth]
//
final class PasswordRemoteDatabaseImpl implements IPasswordRemoteDatabase {
  ///-----------------------------------------------------------------------
  //

  @override
  Future<void> changePassword(String newPassword) async {
    final user = AuthUserUtils.currentUserOrThrow;
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> sendResetLink(String email) async {
    await FirebaseConstants.fbAuth.sendPasswordResetEmail(email: email);
  }

  //
}
