import '../../../../core/utils_shared/type_definitions.dart';
import '../repo_contracts.dart';

/// 📦 [SignUpUseCase] — Handles user registration via [ISignUpRepo]
//
final class SignUpUseCase {
  ///-------------------
  //
  final ISignUpRepo repo;
  const SignUpUseCase(this.repo);
  //
  /// 🔐 Register a new user and returns result
  ResultFuture<void> call({
    required String name,
    required String email,
    required String password,
  }) => repo.signup(name: name, email: email, password: password);
  //
}
