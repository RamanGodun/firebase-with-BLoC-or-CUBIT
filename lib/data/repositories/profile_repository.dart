import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/constants/app_constants.dart' show AppConstants;
import '../../core/entities/user_model.dart';
import '../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../data_transfer_objects/user_dto.dart';

/// 📦 [ProfileRepository]
/// Handles loading user profile from Firestore by UID.
/// Converts Firestore DTO to domain-level [User] model.
class ProfileRepository {
  final FirebaseFirestore firestore;

  const ProfileRepository({required this.firestore});

  /// 🔎 Fetches user profile by [uid] from Firestore
  Future<User> getProfile({required String uid}) async {
    try {
      final doc =
          await firestore
              .collection(AppConstants.usersCollection)
              .doc(uid)
              .get();

      if (!doc.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
          message: 'User document not found in Firestore',
        );
      }

      return UserDto.fromDoc(doc).toDomain();
    } catch (e) {
      throw handleException(e);
    }
  }
}
