import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../../../core/shared_moduls/errors_handling/either/either.dart';
import '../../../../core/shared_moduls/errors_handling/handle_exception.dart';
import '../../../../core/shared_moduls/errors_handling/typedef.dart';
import '../../../../core/presentation/constants/app_constants.dart';
import '../../../shared/shared_data/data_transfer_objects/user_dto.dart';

/// 🧩 [AuthRepository]
/// 🧼 Handles all authentication-related logic:
///    - 🔐 Sign in / sign up
///    - 🧾 User stream
///    - ☁️ Firestore profile initialization
///    - 🚪 Sign out
class AuthRepository {
  final FirebaseFirestore firestore;
  final fb_auth.FirebaseAuth firebaseAuth;

  const AuthRepository({required this.firestore, required this.firebaseAuth});

  /// 🔁 Emits current Firebase user
  Stream<fb_auth.User?> get user => firebaseAuth.userChanges();

  /// 👤 Registers new user & creates Firestore profile
  ResultFuture<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;
      final userDto = UserDTO.newUser(id: user.uid, name: name, email: email);

      await firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(userDto.toMap());

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  /// ☁️ Ensures Firestore profile exists after login/signup
  ResultFuture<void> ensureUserProfileCreated(fb_auth.User user) async {
    try {
      final docRef = firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        final userDto = UserDTO.newUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );

        await docRef.set(userDto.toMap());
      }

      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  /// 🔐 Signs in with email & password
  ResultFuture<fb_auth.UserCredential> signin({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(result);
    } catch (e) {
      return Left(handleException(e));
    }
  }

  /// 🚪 Signs out the user
  ResultFuture<void> signout() async {
    try {
      await firebaseAuth.signOut();
      return const Right(null);
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
