import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_data_transfer_objects/user_dto_utils_x.dart';
import '../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '../../../core/general_utils/typedef.dart';
import '../../../core/shared_layers/shared_data_transfer_objects/_user_dto.dart';
import 'data_source_contract.dart';
import '../../../core/app_configs/firebase/data_source_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_layers/shared_domain/repo_contracts/base_repo.dart';

/// 🧩 [ProfileRemoteDataSourceImpl] — Fetches user data from Firestore
/// ✅ Returns [UserDTO] wrapped in Result for safe error handling
//----------------------------------------------------------------

final class ProfileRemoteDataSourceImpl extends BaseRepository
    implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl(this.firestore);

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

    return UserDTOUtilsX.fromDoc(doc);
  });

  //
}
