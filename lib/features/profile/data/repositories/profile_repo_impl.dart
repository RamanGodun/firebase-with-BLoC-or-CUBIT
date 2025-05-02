import 'package:firebase_with_bloc_or_cubit/core/utils/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_domain/entities/user.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/repositories/profile_repository.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_domain/entities/user_extensions.dart';

import '../data_sources/data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  ResultFuture<User> getProfile({required String uid}) async {
    final result = await remote.getUserDTO(uid);
    return result.mapRight((dto) => dto.toEntity());
  }
}
