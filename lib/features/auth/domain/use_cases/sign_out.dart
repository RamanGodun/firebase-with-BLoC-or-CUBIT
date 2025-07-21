import '../../../../core/utils_shared/typedef.dart';
import '../i_repo.dart';

/// 🚪 [SignOutUseCase]
/// ✅ Handles signing out the currently authenticated user
//
final class SignOutUseCase {
  ///---------------------
  //
  final IAuthRepo _repo;
  const SignOutUseCase(this._repo);

  /// 🔐 Signs the user out of Firebase session
  ResultFuture<void> call() => _repo.signOut();
  //
}
