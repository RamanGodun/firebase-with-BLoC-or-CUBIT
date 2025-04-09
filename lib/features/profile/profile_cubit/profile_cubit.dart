import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/entities/user_model.dart';
import '../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../data/repositories/profile_repository.dart';

part 'profile_state.dart';

/// 📘 [ProfileCubit] — Responsible for loading user profile from repository.
class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ProfileCubit({required this.profileRepository})
    : super(ProfileState.initial());

  /// 🔄 Fetches user profile using UID
  Future<void> getProfile({required String uid}) async {
    emit(state.copyWith(profileStatus: ProfileStatus.loading));
    try {
      final user = await profileRepository.getProfile(uid: uid);
      emit(state.copyWith(profileStatus: ProfileStatus.loaded, user: user));
    } on CustomError catch (e) {
      emit(state.copyWith(profileStatus: ProfileStatus.error, error: e));
    }
  }
}
