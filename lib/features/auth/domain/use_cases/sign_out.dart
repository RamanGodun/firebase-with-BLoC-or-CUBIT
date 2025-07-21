import '../../../../core/utils_shared/typedef.dart';
import '../i_repo.dart';

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
