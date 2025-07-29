import '../../../app_bootstrap_and_config/app_configs/firebase/firebase_constants.dart';
import '../../../core/utils_shared/auth_state/auth_user_utils.dart';
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
