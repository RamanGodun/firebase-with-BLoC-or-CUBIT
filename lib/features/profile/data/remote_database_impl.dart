import 'package:cloud_firestore/cloud_firestore.dart' show CollectionReference;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import '../../../app_bootstrap_and_config/app_configs/firebase/firebase_constants.dart';
import 'remote_database_contract.dart';

/// 🛠️ [ProfileRemoteDatabaseImpl] — Firestore implementation of [IProfileRemoteDatabase]
/// ✅ Only low-level calls to Firestore/Auth, no business logic, no DTO<->Entity mapping
//
final class ProfileRemoteDatabaseImpl implements IProfileRemoteDatabase {
  ///---------------------------------------------------------------------
  //
  final CollectionReference<Map<String, dynamic>> _usersCollection;
  final FirebaseAuth _fbAuth;
  //
  ProfileRemoteDatabaseImpl(this._usersCollection, this._fbAuth);
  //

  /// 📥 Fetches user document by [uid], returns map or null if not found
  @override
  Future<Map<String, dynamic>?> fetchUserMap(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    return doc.data();
  }

  /// 🆕 Creates/updates user map in Firestore for given [uid]
  @override
  Future<void> createUserMap(String uid, Map<String, dynamic> data) async {
    await FirebaseConstants.usersCollection.doc(uid).set(data);
  }

  /// 🔐 Retrieves current authenticated user's basic info (for profile creation)
  @override
  Future<Map<String, dynamic>?> getCurrentUserAuthData() async {
    final user = _fbAuth.currentUser;
    if (user == null) return null;
    return {
      'uid': user.uid,
      'name': user.displayName ?? '',
      'email': user.email ?? '',
    };
  }

  //
}
