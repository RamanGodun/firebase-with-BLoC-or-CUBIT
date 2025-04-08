import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/utils_and_services/errors_handling/handle_exception.dart';
import '../../core/entities/user_model.dart';
import '../data_transfer_objects/user_dto.dart';
import '../sources/remote_firebase/firebase_constants.dart'
    show usersCollection;

class ProfileRepository {
  final FirebaseFirestore firestore;
  const ProfileRepository({required this.firestore});

  Future<User> getProfile({required String uid}) async {
    try {
      // final doc = await firestore.collection('users').doc(uid).get();
      final doc = await usersCollection.doc(uid).get();

      if (!doc.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
          message: 'User document not found in Firestore',
        );
      }
      return UserDto.fromDoc(doc).toDomain();
      // return User.fromDoc(doc);
    } catch (e) {
      throw handleException(e);
    }
  }
}
