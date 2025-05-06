import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repo.dart';

/// ✅ [EnsureUserProfileCreatedUseCase]
/// 🧩 Ensures the Firestore profile exists after user logs in
//----------------------------------------------------------------

final class EnsureUserProfileCreatedUseCase {
  final AuthRepo _repo;
  const EnsureUserProfileCreatedUseCase(this._repo);

  /// 🧱 Executes profile existence check & creates one if missing
  ResultFuture<void> call(fb_auth.User user) =>
      _repo.ensureUserProfileCreated(user);
}
