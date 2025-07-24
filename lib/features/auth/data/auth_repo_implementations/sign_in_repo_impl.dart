import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/failure_handling.dart';
import '../../../../core/utils_shared/typedef.dart';
import '../../domain/repo_contracts.dart';
import '../data_source_contract.dart';

/// 🧩 [SignInRepoImpl] — sign-in in [IAuthRemoteDatabase] with errors mapping
//
final class SignInRepoImpl implements ISignInRepo {
  ///---------------------------------------------
  //
  final IAuthRemoteDatabase _remote;
  const SignInRepoImpl(this._remote);
  //
  @override
  ResultFuture<void> signIn({
    required String email,
    required String password,
  }) =>
      (() => _remote.signIn(email: email, password: password))
          .runWithErrorHandling();
}
