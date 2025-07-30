import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/failure_handling.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/type_definitions.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/user_data_transfer_objects/user_dto_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/shared_entities/_user.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/repo_contract.dart';
import '../../../core/utils_shared/timing_control/timing_config.dart';
import '../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../core/shared_data_layer/user_data_transfer_objects/_user_dto.dart';
import '../../../core/shared_data_layer/user_data_transfer_objects/user_dto_factories_x.dart';
import '../../../core/utils_shared/cash_manager/cache_manager.dart';
import 'remote_database_contract.dart';

/// 🧩 [ProfileRepoImpl] — Repository implementation for profile feature with cache manager composition
/// ✅ Handles in-memory and in-flight cache, mapping, and error handling
//
final class ProfileRepoImpl implements IProfileRepo {
  ///─────────────────────────--------------------
  //
  final IProfileRemoteDatabase _remoteDatabase;
  final CacheManager<UserEntity, String> _cacheManager;
  //
  ProfileRepoImpl(
    this._remoteDatabase, {
    CacheManager<UserEntity, String>? cacheManager,
  }) : _cacheManager =
           cacheManager ??
           CacheManager<UserEntity, String>(ttl: AppDurations.min10);
  //

  ////

  /// Returns cached user if fresh, otherwise fetches from remote
  @override
  ResultFuture<UserEntity> getProfile({required String uid}) =>
      (() async {
        return await _cacheManager.execute(uid, () => _fetchProfile(uid));
      }).runWithErrorHandling();

  /// Force refresh profile (bypasses cache)
  ResultFuture<UserEntity> refreshProfile({required String uid}) =>
      (() async {
        return await _cacheManager.execute(
          uid,
          () => _fetchProfile(uid),
          forceRefresh: true,
        );
      }).runWithErrorHandling();

  /// Fetches user profile from remote source
  Future<UserEntity> _fetchProfile(String uid) async {
    final data = await _remoteDatabase.fetchUserMap(uid);
    if (data == null) throw FirebaseFailure(message: 'User not found');
    final dto = UserDTOFactories.fromMap(data, id: uid);
    return dto.toEntity();
  }

  ////

  /// ♻️ Clears all profile cache
  @override
  void clearCache() => _cacheManager.clear();

  /// 📊 Get cache statistics (useful for debugging)
  CacheStats get cacheStats => _cacheManager.stats;

  ////

  ////

  /// 🆕 Creates a new user profile in database for current user.
  @override
  ResultFuture<void> createUserProfile(String uid) =>
      () async {
        final authData = await _remoteDatabase.getCurrentUserAuthData();
        if (authData == null) {
          throw FirebaseFailure(message: 'No authorized user!');
        }

        final dto = _buildUserDTO(authData, uid);
        await _remoteDatabase.createUserMap(dto.id, dto.toJsonMap());

        // Remove from cache to force fresh fetch next time
        _cacheManager.remove(uid);
      }.runWithErrorHandling();

  /// Factory for building [UserDTO] from auth data
  UserDTO _buildUserDTO(Map<String, dynamic> authData, String fallbackUid) {
    return UserDTOFactories.newUser(
      id: authData['uid'] ?? fallbackUid,
      name: authData['name'] ?? '',
      email: authData['email'] ?? '',
    );
  }

  //
}
