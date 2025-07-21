import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/use_cases_contracts/base_use_case.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/i_repo.dart';
import 'shared_entities/_user.dart';

/// 🧩 [FetchProfileUseCase2] — Gets user profile from repository by UID, if not exist - create
//
final class FetchProfileUseCase
    extends BaseUseCaseWithParams<UserEntity, String> {
  ///-----------------------------------------------
  final IProfileRepo _repo;
  const FetchProfileUseCase(this._repo);

  @override
  ResultFuture<UserEntity> call(String uid) async {
    // 1️⃣ Пробуємо отримати профіль
    final result = await _repo.getProfile(uid: uid);
    if (result.isRight) return result;

    // 2️⃣ Якщо не знайдено — пробуємо створити профіль (чистий абстрактний метод)
    result.leftOrNull?.log();
    await _repo.createUserProfile(uid);

    // 3️⃣ Ще раз пробуємо отримати профіль після створення
    return _repo.getProfile(uid: uid);
  }
}
