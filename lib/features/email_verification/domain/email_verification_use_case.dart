import '../../../core/utils_shared/type_definitions.dart';
import 'repo_contract.dart';

/// 📦 [EmailVerificationUseCase] — encapsulates email verification logic
//
final class EmailVerificationUseCase {
  ///------------------------------
  //
  final IUserValidationRepo repo;
  const EmailVerificationUseCase(this.repo);

  /// 📧 Sends verification email
  ResultFuture<void> sendVerificationEmail() => repo.sendEmailVerification();

  /// 📧 Sends verification email
  ResultFuture<void> reloadUser() => repo.reloadUser();

  /// ✅ Checks email verification status
  ResultFuture<bool> checkIfEmailVerified() async {
    await repo.reloadUser();
    return repo.isEmailVerified();
  }

  //
}
