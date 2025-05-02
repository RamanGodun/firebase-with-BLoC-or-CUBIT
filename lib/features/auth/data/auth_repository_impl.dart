import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_with_bloc_or_cubit/core/utils/typedef.dart';
import '../domain/repositories/auth_repo.dart';
import 'data_source.dart';

/// 🧩 [AuthRepositoryImpl]
/// 🧼 Implements [AuthRepo] using [AuthRemoteDataSource]
//----------------------------------------------------------------//
class AuthRepositoryImpl implements AuthRepo {
  final AuthRemoteDataSource _remoteDataSource;
  const AuthRepositoryImpl(this._remoteDataSource);

  @override
  Stream<fb_auth.User?> get user => _remoteDataSource.user;

  @override
  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signUp(
      name: name,
      email: email,
      password: password,
    );
  }

  @override
  ResultFuture<fb_auth.UserCredential> signIn({
    required String email,
    required String password,
  }) {
    return _remoteDataSource.signIn(email: email, password: password);
  }

  @override
  ResultFuture<void> signOut() => _remoteDataSource.signOut();

  @override
  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user) {
    return _remoteDataSource.ensureUserProfileCreated(user);
  }
}
