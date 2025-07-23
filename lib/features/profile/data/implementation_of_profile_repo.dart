import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/failure_handling.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/user_data_transfer_objects/user_dto_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/shared_entities/_user.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/repo_contract.dart';
import '../../../app_bootstrap_and_config/app_configs/firebase/data_source_constants.dart';
import '../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../core/shared_data_layer/user_data_transfer_objects/user_dto_factories_x.dart';
import 'remote_database_contract.dart';

/// 🧩 [ProfileRepoImpl] — Repository implementation for profile feature.
/// ✅ Maps data between raw maps, DTOs, and domain entities.
/// ✅ Handles error mapping and business logic.
//
final class ProfileRepoImpl implements IProfileRepo {
  ///---------------------------------------------
  //
  final IProfileRemoteDatabase _remoteDataSource;
  ProfileRepoImpl(this._remoteDataSource);

  /// 📦 Loads and maps user profile by UID, throws if not found.
  @override
  ResultFuture<UserEntity> getProfile({required String uid}) =>
      () async {
        final data = await _remoteDataSource.fetchUserMap(uid);
        if (data == null) throw FirebaseFailure(message: 'User not found');
        final dto = UserDTOFactories.fromMap(data, id: uid);
        return dto.toEntity();
      }.runWithErrorHandling();

  /// 🆕 Creates a new user profile in database for current user.
  @override
  ResultFuture<void> createUserProfile(String uid) =>
      () async {
        final user =
            DataSourceConstants
                .fbAuth
                .currentUser; //! depends on specific remote DB
        // ? solution: inject _authDataLayerService with getCurrentUser() method

        if (user == null) throw FirebaseFailure(message: 'No authorized user!');
        final dto = UserDTOFactories.newUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await _remoteDataSource.createUserMap(user.uid, dto.toJsonMap());
      }.runWithErrorHandling();

  //
}
