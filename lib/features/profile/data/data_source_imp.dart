import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/repo_contracts/base_repo.dart';
import '../../../app_bootstrap_and_config/app_configs/firebase/data_source_constants.dart';
import 'data_source_contract.dart';

/// 🧩 [ProfileRemoteDataSourceImpl] — Firestore data source for profile feature.
//
final class ProfileRemoteDataSourceImpl extends BaseRepository
    implements IProfileRemoteDatabase {
  ///---------------------------------------------------------------
  //
  final FirebaseFirestore firestore;
  ProfileRemoteDataSourceImpl(this.firestore);

  /// 📥 Fetches raw user map from Firestore by UID.
  @override
  Future<Map<String, dynamic>?> fetchUserMap(String uid) async {
    final doc = await DataSourceConstants.usersCollection.doc(uid).get();
    return doc.data();
  }

  /// 🆕 Creates user map in Firestore for given UID.
  @override
  Future<void> createUserMap(String uid, Map<String, dynamic> data) async {
    await DataSourceConstants.usersCollection.doc(uid).set(data);
  }

  //
}
