import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repo.dart';

class SignUpUseCase {
  final AuthRepo _repo;
  const SignUpUseCase(this._repo);

  ResultFuture<void> call({
    required String name,
    required String email,
    required String password,
  }) {
    return _repo.signUp(name: name, email: email, password: password);
  }
}
