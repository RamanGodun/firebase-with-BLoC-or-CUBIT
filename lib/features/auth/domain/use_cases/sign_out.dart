import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/core_utils/errors_observing/result_loggers/result_logger_x.dart';
import '../../../../core/utils_shared/type_definitions.dart';
import '../repo_contracts.dart';

/// 📦 [SignOutUseCase] — Handles sign-out logic via [ISignOutRepo]
//
final class SignOutUseCase {
  ///--------------------
  //
  final ISignOutRepo repo;
  const SignOutUseCase(this.repo);
  //
  ResultFuture<void> call() =>
      repo.signOut()
        ..log()
        ..logSuccess('SignOutUseCase success');
  //
}
