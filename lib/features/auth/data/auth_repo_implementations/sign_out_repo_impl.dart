import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/_run_errors_handling.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import '../../domain/repo_contracts.dart';
import '../data_source_contract.dart';

/// 🧩 [SignOutRepoImpl] — sign-out from [IAuthRemoteDatabase] with errors mapping
//
final class SignOutRepoImpl implements ISignOutRepo {
  ///-----------------------------------------------
  //
  final IAuthRemoteDatabase _remote;
  const SignOutRepoImpl(this._remote);
  //
  @override
  ResultFuture<void> signOut() =>
      (() => _remote.signOut()).runWithErrorHandling();
}
