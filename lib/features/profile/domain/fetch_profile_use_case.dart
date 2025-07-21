import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/use_cases_contracts/base_use_case.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/i_repo.dart';
import 'shared_entities/_user.dart';

/// 🧩 [FetchProfileUseCase] — Gets user profile from repository by UID
//
final class FetchProfileUseCase
    extends BaseUseCaseWithParams<UserEntity, String> {
  ///---------------------------------------------------------------
  //
  final IProfileRepo _repository;
  const FetchProfileUseCase(this._repository);

  @override
  ResultFuture<UserEntity> call(String uid) async {
    final result = await _repository.getProfile(uid: uid);
    result.leftOrNull?.log();
    return result;
  }

  //
}
