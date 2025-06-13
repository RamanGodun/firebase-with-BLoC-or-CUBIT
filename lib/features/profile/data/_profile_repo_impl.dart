import 'package:firebase_with_bloc_or_cubit/core/general_utils/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_data_transfer_objects/user_dto_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_domain/shared_entities/_user.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/profile_repository.dart';

import 'data_source_contract.dart';

/// 🧩 [ProfileRepoImpl] — Concrete implementation using remote data source
/// ✅ Maps [UserDTO] → [User] via `.toEntity()`
//----------------------------------------------------------------

final class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource remote;

  ProfileRepoImpl(this.remote);

  @override
  ResultFuture<User> getProfile({required String uid}) async {
    final result = await remote.getUserDTO(uid);
    return result.mapRight((dto) => dto.toEntity());
  }
}
