import 'package:firebase_with_bloc_or_cubit/core/utils/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_domain/shared_entities/_user.dart';

/// 📦 [ProfileRepo] — Contract for loading user profile by UID
//----------------------------------------------------------------

abstract interface class ProfileRepo {
  ResultFuture<User> getProfile({required String uid});
}
