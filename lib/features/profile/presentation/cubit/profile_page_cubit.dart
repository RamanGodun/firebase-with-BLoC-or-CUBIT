import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/extensions/on_failure/_failure_x_imports.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/shared_modules/errors_handling/handlers/result_handler.dart';
import '../../../shared/shared_domain/shared_entities/_user.dart';
import '../../../../core/shared_modules/errors_handling/failure.dart';
import '../../../shared/shared_domain/shared_entities/user_utils_x.dart';
import '../../domain/load_profile_use_case.dart';

part 'profile_page_state.dart';

/// 🧩 [ProfileCubit] — Manages user profile loading by UID
/// ✅ Uses [ResultHandler] to map domain result into UI state transitions
//----------------------------------------------------------------

final class ProfileCubit extends Cubit<ProfileState> {
  final LoadProfileUseCase _loadProfile;

  ProfileCubit(this._loadProfile) : super(ProfileState.initial());

  /// 🚀 Loads user profile and emits corresponding UI states
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

  ///
}
