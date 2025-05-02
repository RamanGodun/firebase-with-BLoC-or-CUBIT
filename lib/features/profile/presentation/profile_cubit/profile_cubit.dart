import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/extensions/failure_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/shared_modules/errors_handling/result_handler.dart';
import '../../../shared/shared_domain/entities/user.dart';
import '../../../../core/shared_modules/errors_handling/failure.dart';
import '../../domain/use_cases/load_profile_use_case.dart';

part 'profile_state.dart';

/// 🧩 [ProfileCubit] — manages user profile loading by UID
/// 🧼 Uses `Result<Failure, UserModel>` to map domain logic into UI states
//----------------------------------------------------------------//

class ProfileCubit extends Cubit<ProfileState> {
  final LoadProfileUseCase _loadProfile;

  ProfileCubit(this._loadProfile) : super(ProfileState.initial());

  Future<void> loadProfile(String uid) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await _loadProfile(uid);

    ResultHandler(result)
        .onSuccess(
          (user) =>
              emit(state.copyWith(status: ProfileStatus.loaded, user: user)),
        )
        .onFailure(
          (failure) => emit(
            state.copyWith(status: ProfileStatus.error, failure: failure),
          ),
        )
        .log();
  }
}
