import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/base_modules/errors_handling/failures/failure__entity.dart';
import '../../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable.dart';
import '../../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable_x.dart';
import '../../../../core/utils_shared/timing_control/timing_config.dart';
import '../../../../app_bootstrap_and_config/firebase_config/user_auth_cubit/auth_cubit.dart';
import '../../domain/email_verification_use_case.dart';

part 'email_verification_state.dart';

/// Handles the email verification flow, including sending the email,
/// polling for verification, and timing out if necessary.
//
final class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  ///------------------------------------------------------------------
  //
  final EmailVerificationUseCase _useCase;
  final AuthCubit _authCubit;

  EmailVerificationCubit(this._useCase, this._authCubit)
    : super(const EmailVerificationState()) {
    _startPolling();
  }
  //

  Timer? _pollingTimer;
  final Stopwatch _stopwatch = Stopwatch();
  static const _maxPollingDuration = AppDurations.min1;
  bool _started = false;
  //

  /// Initializes the verification flow once (send email + start polling).
  Future<void> initVerificationFlow() async {
    if (_started) return;
    _started = true;
    await sendVerificationEmail();
    _startPolling();
  }

  /// Starts polling every 3 seconds to check if email is verified.
  /// Stops polling if verification succeeds or timeout is reached.
  void _startPolling() {
    _pollingTimer?.cancel();
    _stopwatch.reset();
    _stopwatch.start();
    //
    _pollingTimer = Timer.periodic(AppDurations.sec3, (_) async {
      if (_stopwatch.elapsed >= _maxPollingDuration) {
        _stopPolling();
        emit(
          state.copyWith(
            status: EmailVerificationStatus.failure,
            failure: EmailVerificationFailure.timeoutExceeded().asConsumable(),
          ),
        );
        return;
      }
      //
      await checkVerified();
    });
  }

  /// Stops polling and resets the stopwatch.
  void _stopPolling() {
    _pollingTimer?.cancel();
    _stopwatch.stop();
  }

  /// Checks if the user has verified their email.
  /// If verified, reloads user and stops polling.
  Future<void> checkVerified() async {
    emit(state.copyWith(status: EmailVerificationStatus.loading));
    //
    final result = await _useCase.checkIfEmailVerified();
    result.fold(
      (failure) => emit(
        state.copyWith(
          status: EmailVerificationStatus.failure,
          failure: failure.asConsumable(),
        ),
      ),
      //
      (isVerified) async {
        if (isVerified) {
          await _authCubit.reloadUser();
          _stopPolling();
          emit(state.copyWith(status: EmailVerificationStatus.verified));
        } else {
          emit(state.copyWith(status: EmailVerificationStatus.unverified));
        }
      },
    );
  }

  /// Sends the verification email to the user.
  Future<void> sendVerificationEmail() async {
    emit(state.copyWith(status: EmailVerificationStatus.loading));
    //
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

  /// Stops polling and disposes of the cubit.
  @override
  Future<void> close() {
    _stopPolling();
    return super.close();
  }

  //
}
