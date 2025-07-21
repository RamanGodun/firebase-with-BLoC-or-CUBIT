import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_with_bloc_or_cubit/core/utils_shared/typedef.dart';
import '../domain/i_repo.dart';
import 'i_data_source.dart';

/// 🧩 [AuthRepoImpl] — Implements [IAuthRepo] using [AuthRemoteDataSource]
/// ✅ Handles authentication operations and delegates to data source
//
final class AuthRepoImpl implements IAuthRepo {
  ///--------------------------------------
  //
  final AuthRemoteDataSource _remoteDataSource;
  const AuthRepoImpl(this._remoteDataSource);

  /// 📡 Stream of currently authenticated [fb_auth.User]
  @override
  Stream<fb_auth.User?> get user => _remoteDataSource.user;

  /// 📝 Registers a new user with [name], [email], and [password]
  @override
  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  }) => _remoteDataSource.signUp(name: name, email: email, password: password);

  /// 🔐 Signs in an existing user using [email] and [password]
  @override
  ResultFuture<fb_auth.UserCredential> signIn({
    required String email,
    required String password,
  }) => _remoteDataSource.signIn(email: email, password: password);

  /// 🚪 Signs out the currently logged-in user
  @override
  ResultFuture<void> signOut() => _remoteDataSource.signOut();

  /// 👤 Ensures the user's profile exists in the database after sign-up
  @override
  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user) =>
      _remoteDataSource.ensureUserProfileCreated(user);

  //
}
