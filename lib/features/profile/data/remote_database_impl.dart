import 'package:cloud_firestore/cloud_firestore.dart';
import 'remote_database_contract.dart';

/// 🧩 [ProfileRemoteDataSourceImpl] — Firestore data source for profile feature.
//
final class ProfileRemoteDataSourceImpl implements IProfileRemoteDatabase {
  ///---------------------------------------------------------------
  //
  final CollectionReference<Map<String, dynamic>> _usersCollection;
  const ProfileRemoteDataSourceImpl(this._usersCollection);

  /// 📥 Fetches raw user map from Firestore by UID.
  @override
  Future<Map<String, dynamic>?> fetchUserMap(String uid) async {
    final doc = await _usersCollection.doc(uid).get();
    return doc.data();
  }

  /// 🆕 Creates user map in Firestore for given UID.
  @override
  Future<void> createUserMap(String uid, Map<String, dynamic> data) async {
    await _usersCollection.doc(uid).set(data);
  }

  //
}
