import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/utils/errors_observing/loggers/failure_logger_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/utils/extensions_on_either/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/type_definitions.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/repo_contract.dart';
import '../../../core/shared_domain_layer/shared_entities/_user_entity.dart';

/// 🧩 [FetchProfileUseCase] — Encapsulates domain logic of
//     loading profile (with "fetch-or-create" user logic)
//
final class FetchProfileUseCase {
  ///-----------------------------------------------
  //
  final IProfileRepo _repo;
  const FetchProfileUseCase(this._repo);

  /// 🚀 Loads user profile by UID; creates if missing, then reloads.
  ResultFuture<UserEntity> call(String uid) async {
    // 1️⃣ Try to load profile
    final result = await _repo.getProfile(uid: uid);
    if (result.isRight) return result;

    // 2️⃣ If not found, log and create profile
    result.leftOrNull?.log();
    await _repo.createUserProfile(uid);

    // 3️⃣ Try again after creation
    return _repo.getProfile(uid: uid);
  }
}
