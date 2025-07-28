import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable.dart';
import '../../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable_x.dart';
import '../../../../core/utils_shared/auth_state/auth_cubit.dart';
import '../../domain/email_verification_use_case.dart';

part 'email_verification_state.dart';

final class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final EmailVerificationUseCase _useCase;
  final AuthCubit _authCubit;

  EmailVerificationCubit(this._useCase, this._authCubit)
    : super(const EmailVerificationState()) {
    _startPolling();
  }

  Timer? _pollingTimer;

  // Polling every 3 sec
  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      const Duration(seconds: 3),
      (_) => checkVerified(),
    );
  }

  ///
  Future<void> checkVerified() async {
    emit(state.copyWith(status: EmailVerificationStatus.loading));
    final result = await _useCase.checkIfEmailVerified();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EmailVerificationStatus.failure,
          failure: failure.asConsumable(),
        ),
      ),
      (isVerified) async {
        if (isVerified) {
          // 1. Оновити користувача в AuthCubit
          await _authCubit.reloadUser();
          // 2. Зупинити polling
          _pollingTimer?.cancel();
          emit(state.copyWith(status: EmailVerificationStatus.verified));
        } else {
          emit(state.copyWith(status: EmailVerificationStatus.unverified));
        }
      },
    );
  }

  ///
  Future<void> resendEmail() async {
    emit(state.copyWith(status: EmailVerificationStatus.loading));
    final result = await _useCase.sendVerificationEmail();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EmailVerificationStatus.failure,
          failure: failure.asConsumable(),
        ),
      ),
      (_) => emit(state.copyWith(status: EmailVerificationStatus.resent)),
    );
  }

  ///
  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  //
}
