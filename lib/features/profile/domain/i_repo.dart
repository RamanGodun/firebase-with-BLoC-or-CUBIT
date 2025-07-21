import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/shared_entities/_user.dart';

/// 📦 [IProfileRepo] — Contract for loading user profile by UID
///----------------------------------------------------------------
//
abstract interface class IProfileRepo {
  ///-------------------------------
  //
  ///
  ResultFuture<UserEntity> getProfile({required String uid});
  //
  /// ✅ Ensures the user profile exists in the database (e.g. Firestore)
  ResultFuture<void> ensureUserProfileCreated(User user);
  //
}
