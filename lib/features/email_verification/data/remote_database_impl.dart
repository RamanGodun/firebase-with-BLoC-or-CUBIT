import 'package:flutter/foundation.dart' show debugPrint;

import '../../../app_bootstrap_and_config/firebase_config/auth_user_utils.dart';
import 'remote_database_contract.dart';

/// 🛠️ [IUserValidationRemoteDataSourceImpl] — Firebase-powered implementation
/// 🚫 No failure mapping — pure infrastructure logic
//
final class IUserValidationRemoteDataSourceImpl
    implements IUserValidationRemoteDataSource {
  ///----------------------------------------
  //
  @override
  Future<void> sendVerificationEmail() async {
    final user = AuthUserUtils.currentUserOrThrow;
    debugPrint('Sending verification email to: ${user.email}');
    await user.sendEmailVerification();
    debugPrint('Verification email sent!');
  }

  @override
  Future<void> reloadUser() async {
    final user = AuthUserUtils.currentUserOrThrow;
    await user.reload();
  }

  @override
  bool isEmailVerified() {
    return AuthUserUtils.currentUserOrThrow.emailVerified;
  }

  //
}
