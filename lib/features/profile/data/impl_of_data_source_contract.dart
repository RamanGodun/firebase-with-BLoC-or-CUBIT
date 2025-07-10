import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_bloc_or_cubit/features/profile/data/shared_data_transfer_objects/user_dto_factories_x.dart';
import '../../../core/foundation/errors_handling/failures/failure_entity.dart';
import '../../../core/utils_shared/typedef.dart';
import 'shared_data_transfer_objects/_user_dto.dart';
import 'data_source_contract.dart';
import '../../../core/app_configs/firebase/data_source_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/layers_shared/domain_shared/repo_contracts/base_repo.dart';

/// 🧩 [ProfileRemoteDataSourceImpl] — Fetches user data from Firestore
/// ✅ Returns [UserDTO] wrapped in Result for safe error handling

final class ProfileRemoteDataSourceImpl extends BaseRepository
    implements ProfileRemoteDataSource {
  ///---------------------------------------------------------------

  final FirebaseFirestore firestore;
  ProfileRemoteDataSourceImpl(this.firestore);
  //

  @override
  ResultFuture<UserDTO> getUserDTO(String uid) => safeCall(() async {
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

  //
}
