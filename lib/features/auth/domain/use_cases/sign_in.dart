import '../../../../core/utils_shared/typedef.dart';
import '../i_repo.dart';

/// 📦 [SignInUseCase] — Handles user authentication logic, using [ISignInRepo]
//
final class SignInUseCase {
  ///-------------------
  //
  final ISignInRepo authRepo;
  const SignInUseCase(this.authRepo);
  //
  /// 🔐 Signs in with provided credentials
  ResultFuture<void> call({required String email, required String password}) =>
      authRepo.signIn(email: email, password: password);
  //
}
