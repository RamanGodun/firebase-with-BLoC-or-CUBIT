import 'package:firebase_with_bloc_or_cubit/core/utils/typedef.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_domain/use_cases_contracts/base_use_case.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/domain/profile_repository.dart';
import '../../shared/shared_domain/shared_entities/user.dart';

/// 🧩 [LoadProfileUseCase] — Gets user profile from repository by UID
//----------------------------------------------------------------

class LoadProfileUseCase extends UseCaseWithParams<User, String> {
  final ProfileRepository _repository;

  const LoadProfileUseCase(this._repository);

  @override
  ResultFuture<User> call(String uid) => _repository.getProfile(uid: uid);
}
