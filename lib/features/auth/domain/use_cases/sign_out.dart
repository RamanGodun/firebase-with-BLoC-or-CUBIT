import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repo.dart';

class SignOutUseCase {
  final AuthRepo _repo;
  const SignOutUseCase(this._repo);

  ResultFuture<void> call() => _repo.signOut();
}
