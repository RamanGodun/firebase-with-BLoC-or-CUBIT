import 'package:firebase_with_bloc_or_cubit/core/utils/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_domain/shared_entities/user.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/profile_repository.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_domain/shared_entities/user_extensions.dart';

import 'data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  ResultFuture<User> getProfile({required String uid}) async {
    final result = await remote.getUserDTO(uid);
    return result.mapRight((dto) => dto.toEntity());
  }
}
