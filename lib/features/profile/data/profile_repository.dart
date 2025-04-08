import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/utils_and_services/errors_handling/custom_error.dart';
import '../../../core/models/user_model.dart';
import '../../../data/sources/remote/firebase_constants.dart'
    show usersCollection;

class ProfileRepository {
  final FirebaseFirestore firebaseFirestore;
  const ProfileRepository({required this.firebaseFirestore});

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersCollection.doc(uid).get();

      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }

      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }
}
