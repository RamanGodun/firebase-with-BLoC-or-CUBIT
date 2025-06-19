import '../../../../core/utils_shared/typedef.dart';
import '../repositories/auth_repo.dart';

/// 📝 [SignUpUseCase]
/// ✅ Handles user registration via [AuthRepo]

final class SignUpUseCase {
  ///--------------------
  //
  final AuthRepo _repo;
  const SignUpUseCase(this._repo);

  /// 🔐 Registers a new user with [name], [email], and [password]
  ResultFuture<void> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repo.signUp(name: name, email: email, password: password);
  }

  //
}
