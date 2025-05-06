import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_data/shared_data_transfer_objects/user_dto_x.dart';
import '../../../core/shared_modules/errors_handling/either/either.dart';
import '../../../core/shared_modules/errors_handling/handlers/failure_mapper.dart';
import '../../../core/utils/typedef.dart';
import '../../shared/shared_data/shared_data_transfer_objects/user_dto_utils_x.dart';
import '../../shared/shared_data/shared_sources/remote/data_source_constants.dart';
import 'data_source.dart';

/// 🧩 [AuthRemoteDataSourceImpl] — concrete implementation using Firebase
/// ✅ Handles auth & Firestore profile creation
//----------------------------------------------------------------

final class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  ///
  final fb_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  const AuthRemoteDataSourceImpl(this._firebaseAuth, this._firestore);

  /// 📡 Emits auth state changes
  @override
  Stream<fb_auth.User?> get user => _firebaseAuth.userChanges();

  /// 🔐 Email/password sign in
  @override
  ResultFuture<fb_auth.UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(FailureMapper.from(e));
    }
  }

  /// 📝 Registers user in Firebase + creates Firestore profile
  @override
  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
      final userDto = UserDTOUtilsX.newUser(
        id: user.uid,
        name: name,
        email: email,
      );

      await _firestore
          .collection(DataSourceConstants.usersCollection)
          .doc(user.uid)
          .set(userDto.toJsonMap());

      return const Right(null);
    } catch (e) {
      return Left(FailureMapper.from(e));
    }
  }

  /// 🧱 Ensures Firestore profile exists after login (e.g. from other providers)
  @override
  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user) async {
    try {
      final docRef = _firestore
          .collection(DataSourceConstants.usersCollection)
          .doc(user.uid);

      final doc = await docRef.get();

      if (!doc.exists) {
        final userDto = UserDTOUtilsX.newUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await docRef.set(userDto.toJsonMap());
      }

      return const Right(null);
    } catch (e) {
      return Left(FailureMapper.from(e));
    }
  }

  /// 🚪 Signs out current Firebase user
  @override
  ResultFuture<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(FailureMapper.from(e));
    }
  }

  //
}
