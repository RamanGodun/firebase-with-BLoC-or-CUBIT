import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../domain/repo_contract.dart';
import 'remote_database_contract.dart';

/// 🧩 [PasswordRepoImpl] — Delegates password-related calls to [IPasswordRemoteDatabase]
/// 🧼 Adds unified failure handling via `.executeWithFailureHandling()`
//
final class PasswordRepoImpl implements IPasswordRepo {
  ///-----------------------------------------------
  //
  final IPasswordRemoteDatabase _remote;
  const PasswordRepoImpl(this._remote);

  /// 🔁 Changes password for the currently signed-in user
  @override
  ResultFuture<void> changePassword(String newPassword) =>
      (() => _remote.changePassword(newPassword)).runWithErrorHandling();

  /// 📩 Sends reset password link to provided email
  @override
  ResultFuture<void> sendResetLink(String email) =>
      (() => _remote.sendResetLink(email)).runWithErrorHandling();

  //
}
