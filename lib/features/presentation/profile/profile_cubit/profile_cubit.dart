import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/errors_handling/extensions/failure_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';
import '../../../../core/utils_and_services/errors_handling/failure.dart';
import '../../../../core/utils_and_services/errors_handling/result_handler.dart';
import '../../../data/repositories/profile_repository.dart';

part 'profile_state.dart';

/// 🧩 [ProfileCubit] — manages user profile loading by UID
/// 🧼 Uses `Result<Failure, UserModel>` to map domain logic into UI states
//----------------------------------------------------------------//
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(ProfileState.initial());

  /// 🔄 Loads user profile by UID
  Future<void> loadProfile(String uid) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await _repository.getProfile(uid: uid);

    // ✅ Правильно: передаємо Either в ResultHandler<User>
    ResultHandler<User>(result)
        .onFailure(
          (f) => emit(state.copyWith(status: ProfileStatus.error, failure: f)),
        )
        .onSuccess(
          (user) =>
              emit(state.copyWith(status: ProfileStatus.loaded, user: user)),
        )
        .log();
  }
}
