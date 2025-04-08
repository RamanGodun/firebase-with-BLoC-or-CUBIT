import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../../core/models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore firestore;
  const ProfileRepository({required this.firestore});

  Future<User> getProfile({required String uid}) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();

      if (!doc.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
          message: 'User document not found in Firestore',
        );
      }

      return User.fromDoc(doc);
    } catch (e) {
      throw handleException(e);
    }
  }
}
