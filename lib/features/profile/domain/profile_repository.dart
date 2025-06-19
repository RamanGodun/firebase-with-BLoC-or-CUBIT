import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/shared_entities/_user.dart';

/// 📦 [ProfileRepo] — Contract for loading user profile by UID
///----------------------------------------------------------------
//
abstract interface class ProfileRepo {
  ResultFuture<UserEntity> getProfile({required String uid});
  //
}
