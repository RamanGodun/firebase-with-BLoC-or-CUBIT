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
  ResultFuture<void> call() => repo.signOut();
  //
}
