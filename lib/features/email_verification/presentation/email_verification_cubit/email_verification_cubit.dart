import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable.dart';
import '../../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable_x.dart';
import '../../domain/email_verification_use_case.dart';

part 'email_verification_state.dart';

final class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final EmailVerificationUseCase _useCase;

  EmailVerificationCubit(this._useCase)
    : super(const EmailVerificationState()) {
    _startPolling();
  }

  Timer? _pollingTimer;

  // Запускаємо polling кожні 4 секунди
  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(
      const Duration(seconds: 15),
      (_) => checkVerified(),
    );
  }

  // Зупиняємо polling (наприклад, при закритті)
  @override
  Future<void> close() {
    _pollingTimer?.cancel();
    return super.close();
  }

  // Оновити користувача і перевірити верифікацію
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
          await _useCase.reloadUser();
          // ➕ ТУТ ОНОВЛЮЄМО ГЛОБАЛЬНИЙ AUTHCUBIT:
          // (Це pseudo-code! Залежить від твоєї реалізації AuthCubit)
          // context.read<AuthCubit>().reloadUser();
          emit(state.copyWith(status: EmailVerificationStatus.verified));
        } else {
          emit(state.copyWith(status: EmailVerificationStatus.unverified));
        }
      },
    );
  }

  // Надіслати повторно лист
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

  //
}
