import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/_run_errors_handling.dart';
import '../../../core/utils_shared/type_definitions.dart';
import '../domain/repo_contract.dart';
import 'remote_database_contract.dart';

/// 🧩 [IUserValidationRepoImpl] — Repo for email verification, applies error mapping and delegates to [IUserValidationRemoteDataSource]
//
final class IUserValidationRepoImpl implements IUserValidationRepo {
  ///------------------------------------------------------------
  //
  final IUserValidationRemoteDataSource _remote;
  const IUserValidationRepoImpl(this._remote);

  /// 📧 Sends verification email via [IUserValidationRemoteDataSource]
  @override
  ResultFuture<void> sendEmailVerification() =>
      (() => _remote.sendVerificationEmail()).runWithErrorHandling();

  /// 🔁 Reloads current user from [IUserValidationRemoteDataSource]
  @override
  ResultFuture<void> reloadUser() =>
      (() => _remote.reloadUser()).runWithErrorHandling();

  /// ✅ Checks if user's email is verified
  @override
  ResultFuture<bool> isEmailVerified() =>
      (() async => _remote.isEmailVerified()).runWithErrorHandling();

  //
}
