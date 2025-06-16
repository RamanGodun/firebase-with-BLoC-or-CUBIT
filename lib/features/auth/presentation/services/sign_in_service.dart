import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';

import '../../domain/use_cases/ensure_profile_created.dart';
import '../../domain/use_cases/sign_in.dart';
import '../../../../core/shared_modules/errors_handling/either/either.dart';
import '../../../../core/shared_modules/errors_handling/failures/failure_entity.dart';
import '../../../../core/general_utils/typedef.dart';

/// 🧩 [SignInService] — Handles sign-in logic and profile creation
/// ✅ Combines [SignInUseCase] and [EnsureUserProfileCreatedUseCase] into one flow
/// 🔐 Used in `submit()` logic to ensure clean separation of responsibilities

final class SignInService {
  //---------------------

  final SignInUseCase _signIn;
  final EnsureUserProfileCreatedUseCase _ensureProfile;

  const SignInService(this._signIn, this._ensureProfile);

  /// 🚀 Executes sign-in and ensures user profile exists in Firestore
  /// 🔍 Logs all failures internally
  ResultFuture<void> execute({
    required String email,
    required String password,
  }) async {
    final signInResult = await _signIn(email: email, password: password);

    if (signInResult.isLeft) {
      signInResult.leftOrNull?.log();
      return Left(signInResult.leftOrNull!);
    }

    final credential = signInResult.rightOrNull!;
    final user = credential.user;

    if (user == null) {
      final failure = UnknownFailure(message: 'User is null');
      failure.log(); // ❗️Unexpected null user
      return Left(failure);
    }

    final profileResult = await _ensureProfile(user);
    if (profileResult.isLeft) {
      profileResult.leftOrNull?.log();
    }

    return profileResult;
  }

  //
}
