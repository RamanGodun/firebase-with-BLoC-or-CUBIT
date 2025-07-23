import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/repo_contract.dart';
import '../../../core/shared_domain_layer/shared_entities/_user.dart';

//! SPLIT into 2 use cases

/// 🧩 [GetProfileUseCase] — Loads profile or creates if missing.
/// ✅ Orchestrates fetching and recovery flow with proper error logging.
//
final class GetProfileUseCase {
  ///-----------------------------------------------
  //
  final IProfileRepo _repo;
  const GetProfileUseCase(this._repo);

  // 🚀 Loads user profile by UID; creates if missing, then reloads.
  ResultFuture<UserEntity> call(String uid) async {
    // 1️⃣ Try to load profile
    final result = await _repo.getProfile(uid: uid);
    if (result.isRight) return result;

    // 2️⃣ If not found, log and create profile
    result.leftOrNull?.log();
    await _repo.createUserProfile(uid);

    // 3️⃣ Try again after creation
    return _repo.getProfile(uid: uid);

    //
  }
}
