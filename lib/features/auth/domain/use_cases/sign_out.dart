import '../../../../core/general_utils/typedef.dart';
import '../repositories/auth_repo.dart';

/// 🚪 [SignOutUseCase]
/// ✅ Handles signing out the currently authenticated user
//----------------------------------------------------------------

final class SignOutUseCase {
  final AuthRepo _repo;
  const SignOutUseCase(this._repo);

  /// 🔐 Signs the user out of Firebase session
  ResultFuture<void> call() => _repo.signOut();
}
