import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/presentation/constants/app_constants.dart';
import '../../../../core/shared_modules/errors_handling/either/either.dart';
import '../../../../core/shared_modules/errors_handling/failure.dart';
import '../../../../core/shared_modules/errors_handling/handle_exception.dart';
import '../../../../core/utils/typedef.dart';
import '../../../shared/shared_data/data_transfer_objects/user_dto.dart';
import 'data_source.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteDataSourceImpl(this.firestore);

  @override
  ResultFuture<UserDTO> getUserDTO(String uid) async {
    try {
      final doc =
          await firestore
              .collection(AppConstants.usersCollection)
              .doc(uid)
              .get();

      if (!doc.exists) {
        return Left(
          FirebaseFailure(message: 'User document not found in Firestore'),
        );
      }

      return Right(UserDTO.fromDoc(doc));
    } catch (e) {
      return Left(handleException(e));
    }
  }
}
