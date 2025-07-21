import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../../core/utils_shared/typedef.dart';
import 'i_repo.dart';

/// ✅ [EnsureUserProfileCreatedUseCase]
/// 🧩 Ensures the Firestore profile exists after user logs in
//
final class EnsureUserProfileCreatedUseCase {
  ///--------------------------------------
  //
  final IProfileRepo _repo;
  const EnsureUserProfileCreatedUseCase(this._repo);

  /// 🧱 Executes profile existence check & creates one if missing
  ResultFuture<void> call(fb_auth.User user) =>
      _repo.ensureUserProfileCreated(user);
  //
}
