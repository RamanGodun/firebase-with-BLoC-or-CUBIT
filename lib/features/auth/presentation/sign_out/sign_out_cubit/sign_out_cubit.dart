import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/for_bloc/consumable_x.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/for_bloc/result_handler.dart';
import '../../../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../../../core/base_modules/errors_handling/utils/for_bloc/consumable.dart';
import '../../../domain/use_cases/sign_out.dart';

part 'sign_out_state.dart';

/// 🚪 [SignOutCubit] — Handles the user sign out logic
/// ✅ Stateless for now, emits failure/success status if needed
//
final class SignOutCubit extends Cubit<SignOutState> {
  ///---------------------------------------------
  //
  final SignOutUseCase _signOutUseCase;
  SignOutCubit(this._signOutUseCase) : super(const SignOutState());

  Future<void> signOut() async {
    emit(state.copyWith(status: SignOutStatus.loading, failure: null));

    final result = await _signOutUseCase();

    if (isClosed) return;

    ResultHandler(result)
      ..onFailure((f) {
        emit(
          state.copyWith(
            status: SignOutStatus.failure,
            failure: f.asConsumable(),
          ),
        );
      })
      ..onSuccess((_) {
        emit(state.copyWith(status: SignOutStatus.success, failure: null));
      })
      ..log();
  }
}
