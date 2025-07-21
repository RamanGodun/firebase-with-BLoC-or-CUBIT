import '../../../app_bootstrap_and_config/app_configs/firebase/data_source_constants.dart';
import 'data_source_contract.dart';

/// 🛠️ [AuthRemoteDataSourceImpl] — Firebase-powered remote data source.
/// ✅ Implements low-level Firebase logic only.
//
final class AuthRemoteDataSourceImpl implements IAuthRemoteDataSource {
  ///---------------------------------------------------------------
  //
  /// 🔐 Firebase sign-in
  @override
  Future<void> signIn({required String email, required String password}) async {
    await DataSourceConstants.fbAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// 🆕 Firebase sign-up
  @override
  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    final cred = await DataSourceConstants.fbAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    // Return UID only (to stay generic)
    return cred.user?.uid ?? '';
  }

  /// 💾 Save User in Firestore
  @override
  Future<void> saveUserData(String uid, Map<String, dynamic> userData) async {
    await DataSourceConstants.usersCollection.doc(uid).set(userData);
  }

  /// 🔓 Firebase sign-out
  @override
  Future<void> signOut() async {
    await DataSourceConstants.fbAuth.signOut();
  }

  //
}
