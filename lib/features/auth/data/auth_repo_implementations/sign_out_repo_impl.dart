import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../../core/utils_shared/typedef.dart';
import '../../domain/i_repo.dart';
import '../data_source_contract.dart';

/// 🧩 [SignOutRepoImpl] — sign-out from [IAuthRemoteDataSource] with errors mapping
//
final class SignOutRepoImpl implements ISignOutRepo {
  ///-----------------------------------------------
  //
  final IAuthRemoteDataSource _remote;
  const SignOutRepoImpl(this._remote);
  //
  @override
  ResultFuture<void> signOut() =>
      (() => _remote.signOut()).runWithErrorHandling();
}
