import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/repo_contracts/base_repo.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/shared_data_transfer_objects/user_dto_factories_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/shared_data_transfer_objects/user_dto_x.dart';
import '../../../app_bootstrap_and_config/app_configs/firebase/data_source_constants.dart';
import '../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../core/utils_shared/typedef.dart';
import 'data_source_contract.dart';
import '../../../core/shared_data_layer/shared_data_transfer_objects/_user_dto.dart';

/// 🧩 [ProfileRemoteDataSourceImpl] — Fetches user data from Firestore
/// ✅ Returns [UserDTO] wrapped in Result for safe error handling
//
final class ProfileRemoteDataSourceImpl extends BaseRepository
    implements IProfileRemoteDatabase {
  ///---------------------------------------------------------------
  //
  final FirebaseFirestore firestore;
  ProfileRemoteDataSourceImpl(this.firestore);
  //

  @override
  ResultFuture<UserDTO> getUserDTO(String uid) => executeSafely(() async {
    final doc = await DataSourceConstants.usersCollection.doc(uid).get();

    if (!doc.exists) {
      throw FirebaseFailure(
        message: 'User document not found in Firestore, trying to recover data',
      );
    }

    return UserDTOFactories.fromDoc(doc);
  });

  /// 🧱 Ensures Firestore profile exists after login (e.g. from other providers)
  @override
  ResultFuture<void> createUserProfile(String uid) {
    return executeSafelyVoid(() async {
      final user = DataSourceConstants.fbAuth.currentUser;
      if (user == null) throw FirebaseFailure(message: 'No authorized user!');
      final docRef = DataSourceConstants.usersCollection.doc(uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        final userDto = UserDTOFactories.newUser(
          id: user.uid,
          name: user.displayName ?? '',
          email: user.email ?? '',
        );
        await docRef.set(userDto.toJsonMap());
      }
    });
  }

  //
}
