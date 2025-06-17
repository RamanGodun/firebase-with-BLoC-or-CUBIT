import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/layers_shared/domain_shared/use_cases_contracts/base_use_case.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/profile_repository.dart';
import 'shared_entities/_user.dart';

/// 🧩 [LoadProfileUseCase] — Gets user profile from repository by UID

final class LoadProfileUseCase
    extends BaseUseCaseWithParams<UserEntity, String> {
  //----------------------------------------------------------------

  final ProfileRepo _repository;

  const LoadProfileUseCase(this._repository);

  @override
  ResultFuture<UserEntity> call(String uid) async {
    final result = await _repository.getProfile(uid: uid);
    result.leftOrNull?.log();
    return result;
  }

  //
}
