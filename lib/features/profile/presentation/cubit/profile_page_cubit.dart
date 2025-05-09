// 📦 profile_page_cubit.dart

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/utils/consumable.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/_failure_x_imports.dart';
import '../../../../core/shared_modules/errors_handling/failures/failure_ui_model.dart';
import '../../../../core/shared_modules/errors_handling/dsl_like_result/result_handler.dart';
import '../../../shared/shared_domain/shared_entities/_user.dart';
import '../../../shared/shared_domain/shared_entities/user_utils_x.dart';
import '../../domain/load_profile_use_case.dart';

part 'profile_page_state.dart';

/// 🧩 [ProfileCubit] — Manages user profile loading by UID
/// ✅ Uses [DSLLikeResultHandler] to map domain result into UI state transitions
//----------------------------------------------------------------

final class ProfileCubit extends Cubit<ProfileState> {
  final LoadProfileUseCase _loadProfile;

  ProfileCubit(this._loadProfile) : super(ProfileState.initial());

  /// 🚀 Triggers user profile loading by [uid]
  /// ✅ Emits: loading → loaded | error
  Future<void> loadProfile(String uid) async {
    emit(state.copyWith(status: ProfileStatus.loading));

    final result = await _loadProfile(uid);

    DSLLikeResultHandler(result)
      ..onSuccess((user) {
        emit(state.copyWith(status: ProfileStatus.loaded, user: user));
      })
      ..onFailure((failure) {
        emit(
          state.copyWith(
            status: ProfileStatus.error,
            failure: failure.asConsumableUIModel(),
          ),
        );
      })
      ..log();
  }

  /// 🧽 Resets failure after it's consumed by UI
  void clearFailure() => emit(state.copyWith(failure: null));

  ///
}
