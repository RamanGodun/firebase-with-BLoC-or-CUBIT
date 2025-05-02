import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_with_bloc_or_cubit/core/entities/user_extensions.dart';
import '../../core/constants/app_constants.dart';
import '../../core/entities/user.dart';
import '../../core/utils_and_services/errors_handling/failure.dart';
import '../../core/utils_and_services/errors_handling/either/either.dart';
import '../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../core/utils_and_services/errors_handling/typedef.dart';
import '../data_transfer_objects/user_dto.dart';

/// 📦 [ProfileRepository]
/// 🧼 Loads profile by UID from Firestore and maps to domain [User]
class ProfileRepository {
  final FirebaseFirestore firestore;

  const ProfileRepository({required this.firestore});

  /// 🔎 [getProfile] — safely fetches user data from Firestore
  ResultFuture<User> getProfile({required String uid}) async {
    try {
      final docRef = firestore
          .collection(AppConstants.usersCollection)
          .doc(uid);

      final doc = await docRef.get();

      if (!doc.exists) {
        return Left(
          FirebaseFailure(message: 'User document not found in Firestore'),
        );
      }

      final user = UserDTO.fromDoc(doc).toEntity();
      return Right(user);
    } catch (error) {
      return Left(handleException(error));
    }
  }

  ///
}
