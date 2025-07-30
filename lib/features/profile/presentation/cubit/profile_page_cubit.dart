import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/to_ui_failure_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/for_bloc/consumable.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/for_bloc/consumable_x.dart';
import '../../../../core/base_modules/errors_handling/failures/failure_ui_model.dart';
import '../../domain/fetch_profile_use_case.dart';
import '../../../../core/shared_domain_layer/shared_entities/_user_entity.dart';

part 'profile_page_state.dart';

/// 🧩 [ProfileCubit] — State manager for profile loading and errors.
/// ✅ Uses AZER (Async, Zero side effects, Error handling, Reactive) pattern.
//
final class ProfileCubit extends Cubit<ProfileState> {
  ///-----------------------------------------------
  //
  final FetchProfileUseCase _fetchProfileUsecase;
  ProfileCubit(this._fetchProfileUsecase) : super(const ProfileInitial());
  //

  /// 🚀 Loads user profile by UID
  Future<void> loadProfile(String uid) async {
    //
    emit(const ProfileLoading());

    final result = await _fetchProfileUsecase(uid);

    result.fold(
      (f) => emit(ProfileError(f.toUIEntity().asConsumable())),
      (u) => emit(ProfileLoaded(u)),
    );
  }

  /// 🧽 Clears failure after UI consumed it
  void clearFailure() {
    if (state is ProfileError) {
      emit(const ProfileInitial());
    }
  }

  //
}
