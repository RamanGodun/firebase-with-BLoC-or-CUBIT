import '../../../../core/utils_shared/typedef.dart';
import '../i_repo.dart';

/// 📝 [SignUpUseCase]
/// ✅ Handles user registration via [IAuthRepo]
//
final class SignUpUseCase {
  ///--------------------
  //
  final IAuthRepo _repo;
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
