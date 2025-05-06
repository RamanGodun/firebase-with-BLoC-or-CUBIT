import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_bloc_or_cubit/features/shared/shared_data/shared_data_transfer_objects/user_dto_utils_x.dart';
import '../../../core/shared_modules/errors_handling/either/either.dart';
import '../../../core/shared_modules/errors_handling/failure.dart';
import '../../../core/shared_modules/errors_handling/handlers/handle_exception.dart';
import '../../../core/utils/typedef.dart';
import '../../shared/shared_data/shared_data_transfer_objects/_user_dto.dart';
import 'data_source.dart';
import '../../shared/shared_data/shared_sources/remote/data_source_constants.dart';

/// 🧩 [ProfileRemoteDataSourceImpl] — Fetches user data from Firestore
/// ✅ Returns [UserDTO] wrapped in Result for safe error handling
//----------------------------------------------------------------

final class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl(this.firestore);

  @override
  ResultFuture<UserDTO> getUserDTO(String uid) async {
    try {
      final doc =
          await firestore
              .collection(DataSourceConstants.usersCollection)
              .doc(uid)
              .get();

      if (!doc.exists) {
        return Left(
          FirebaseFailure(message: 'User document not found in Firestore'),
        );
      }

      return Right(UserDTOUtilsX.fromDoc(doc));
    } catch (e) {
      return Left(FailureMapper.from(e));
    }
  }
}
