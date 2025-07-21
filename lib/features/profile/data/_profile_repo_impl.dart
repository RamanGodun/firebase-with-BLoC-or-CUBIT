import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/shared_data_transfer_objects/user_dto_x.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/shared_entities/_user.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/i_repo.dart';

import 'data_source_contract.dart';

/// 🧩 [ProfileRepoImpl] — Concrete implementation using remote data source
/// ✅ Maps [UserDTO] → [UserEntity] via `.toEntity()`
//
final class ProfileRepoImpl implements IProfileRepo {
  ///---------------------------------------------
  //
  final IProfileRemoteDatabase _remoteDataSource;
  ProfileRepoImpl(this._remoteDataSource);
  //

  @override
  ResultFuture<UserEntity> getProfile({required String uid}) async {
    final result = await _remoteDataSource.getUserDTO(uid);
    return result.mapRight((dto) => dto.toEntity());
  }

  /// 👤 Ensures the user's profile exists in the database after sign-up
  @override
  ResultFuture<void> createUserProfile(String uid) =>
      _remoteDataSource.createUserProfile(uid);

  //
}
