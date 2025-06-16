import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_data_transfer_objects/user_dto_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_domain/repo_contracts/base_repo.dart';
import '../../../core/general_utils/typedef.dart';
import '../../../core/shared_layers/shared_data_transfer_objects/user_dto_utils_x.dart';
import '../../../core/app_configs/firebase/data_source_constants.dart';
import 'data_source_contract.dart';

/// 🧩 [AuthRemoteDataSourceImpl] — concrete implementation using Firebase
/// ✅ Handles auth & Firestore profile creation

final class AuthRemoteDataSourceImpl extends BaseRepository
    implements AuthRemoteDataSource {
  //--------------------------------

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
  }) {
    return safeCall(() {
      return _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  /// 📝 Registers user in Firebase + creates Firestore profile
  @override
  ResultFuture<void> signUp({
    required String name,
    required String email,
    required String password,
  }) {
    return safeCallVoid(() async {
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
    });
  }

  /// 🧱 Ensures Firestore profile exists after login (e.g. from other providers)
  @override
  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user) {
    return safeCallVoid(() async {
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
    });
  }

  /// 🚪 Signs out current Firebase user
  @override
  ResultFuture<void> signOut() {
    return safeCallVoid(() => _firebaseAuth.signOut());
  }

  //
}
