import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/shared_entities/_user.dart';

/// 📦 [IProfileRepo] — Contract for loading user profile by UID
///----------------------------------------------------------------
//
abstract interface class IProfileRepo {
  ///-------------------------------
  //
  ///
  ResultFuture<UserEntity> getProfile({required String uid});
  //
  /// ✅ Create the user profile if not exists in the database (e.g. Firestore)
  ResultFuture<void> createUserProfile(String uid);
  //
}
