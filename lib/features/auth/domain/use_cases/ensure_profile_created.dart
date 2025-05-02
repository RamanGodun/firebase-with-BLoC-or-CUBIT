import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repo.dart';

class EnsureUserProfileCreatedUseCase {
  final AuthRepo _repo;
  const EnsureUserProfileCreatedUseCase(this._repo);

  ResultFuture<void> call(fb_auth.User user) =>
      _repo.ensureUserProfileCreated(user);
}
