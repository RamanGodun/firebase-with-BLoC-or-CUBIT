import '../../features/auth/domain/use_cases/ensure_profile_created.dart';
import '../../features/auth/domain/use_cases/sign_in.dart';
import '../shared_modules/errors_handling/either/either.dart';
import '../shared_modules/errors_handling/failure.dart';
import '../shared_modules/errors_handling/extensions/failure_x.dart';
import '../utils/typedef.dart';

/// 🧩 [SignInService] — Handles sign in & ensures profile with logging
/// 🧼 Encapsulates full Cubit submit() logic safely
//----------------------------------------------------------------//
class SignInService {
  final SignInUseCase _signIn;
  final EnsureUserProfileCreatedUseCase _ensureProfile;

  SignInService(this._signIn, this._ensureProfile);

  /// 🚀 Executes sign-in and profile creation, with full logging
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
      const failure = UnknownFailure(message: 'User is null');
      failure.log();
      return const Left(failure);
    }

    final profileResult = await _ensureProfile(user);
    if (profileResult.isLeft) {
      profileResult.leftOrNull?.log();
    }

    return profileResult;
  }
}
