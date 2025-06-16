import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/utils/for_bloc/consumable.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/failure_ui_entity.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/to_ui_failures_x.dart';
import '../../../../core/shared_layers/shared_domain/shared_entities/_user.dart';
import '../../domain/load_profile_use_case.dart';

part 'profile_page_state.dart';

/// 🧩 [ProfileCubit] — Manages profile loading state and side effects.
/// ✅ Emits sealed [ProfileState] values following AZER + Clean Architecture.
//----------------------------------------------------------------------------

final class ProfileCubit extends Cubit<ProfileState> {
  final LoadProfileUseCase _loadProfile;

  ProfileCubit(this._loadProfile) : super(const ProfileInitial());

  /// 🚀 Loads user profile by UID
  Future<void> loadProfile(String uid) async {
    emit(const ProfileLoading());

    final result = await _loadProfile(uid);

    result.fold(
      (f) => emit(ProfileError(f.asConsumableUIEntity())),
      (u) => emit(ProfileLoaded(u)),
    );
  }

  /// 🧽 Clears failure after UI consumed it
  void clearFailure() {
    if (state is ProfileError) {
      emit(const ProfileInitial());
    }
  }

  ///
}
