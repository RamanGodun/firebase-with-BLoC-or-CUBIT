import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';

import '../repositories/auth_repo.dart';

/// 🔐 [SignInUseCase]
/// ✅ Handles user sign-in with email & password

final class SignInUseCase {
  ///---------------------
  //
  final AuthRepo _repo;
  const SignInUseCase(this._repo);

  /// 🚪 Authenticates user using provided credentials
  ResultFuture<fb_auth.UserCredential> call({
    required String email,
    required String password,
  }) {
    return _repo.signIn(email: email, password: password);
  }

  //
}
