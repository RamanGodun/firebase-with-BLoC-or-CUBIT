import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/modules_shared/errors_handling/utils/for_bloc/result_handler.dart';
import '../../../domain/use_cases/sign_out.dart';

part 'sign_out_state.dart';

/// 🚪 [SignOutCubit] — Handles the user sign out logic
/// ✅ Stateless for now, emits failure/success status if needed

final class SignOutCubit extends Cubit<SignOutState> {
  ///-----------------------------------------------

  final SignOutUseCase _signOutUseCase;
  SignOutCubit(this._signOutUseCase) : super(const SignOutState());
  //

  ///
  Future<void> signOut() async {
    emit(state.copyWith(status: SignOutStatus.loading));

    final result = await _signOutUseCase();

    if (isClosed) return;

    ResultHandler(result)
      ..onFailure((f) {
        emit(state.copyWith(status: SignOutStatus.failure));
        // ? Extra actions
      })
      ..onSuccess((_) {
        emit(state.copyWith(status: SignOutStatus.success));
      })
      ..log();
  }

  //
}
