import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either/extensions/_either_x_imports.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/_failure_x_imports.dart';
import '../domain/use_cases/ensure_profile_created.dart';
import '../domain/use_cases/sign_in.dart';
import '../../../core/shared_modules/errors_handling/either/either.dart';
import '../../../core/shared_modules/errors_handling/failures/failure.dart';
import '../../../core/utils/typedef.dart';

/// 🧩 [SignInService] — Handles sign-in logic and profile creation
/// ✅ Combines [SignInUseCase] and [EnsureUserProfileCreatedUseCase] into one flow
/// 🔐 Used in `submit()` logic to ensure clean separation of responsibilities
//----------------------------------------------------------------

final class SignInService {
  ///
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
      signInResult.leftOrNull?.log(); // ❌ Log auth failure
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
      profileResult.leftOrNull?.log(); // ❌ Log profile creation error
    }

    return profileResult;
  }

  ///
}
