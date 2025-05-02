import 'package:firebase_with_bloc_or_cubit/core/utils/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_domain/shared_entities/user.dart';

abstract class ProfileRepository {
  ResultFuture<User> getProfile({required String uid});
}
