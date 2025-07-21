import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/data/shared_data_transfer_objects/user_dto_factories_x.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/data/shared_data_transfer_objects/user_dto_x.dart';
import '../../../core/base_modules/errors_handling/failures/failure_entity.dart';
import '../../../core/utils_shared/typedef.dart';
import 'shared_data_transfer_objects/_user_dto.dart';
import 'data_source_contract.dart';
import '../../../app_bootstrap_and_config/app_configs/firebase/data_source_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_domain_layer/repo_contracts/base_repo.dart';

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
    final doc =
        await firestore
            .collection(DataSourceConstants.usersCollection)
            .doc(uid)
            .get();

    if (!doc.exists) {
      throw FirebaseFailure(message: 'User document not found in Firestore');
    }

    return UserDTOFactories.fromDoc(doc);
  });

  /// 🧱 Ensures Firestore profile exists after login (e.g. from other providers)
  @override
  ResultFuture<void> ensureUserProfileCreated(User user) {
    return executeSafelyVoid(() async {
      final docRef = firestore
          .collection(DataSourceConstants.usersCollection)
          .doc(user.uid);

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
