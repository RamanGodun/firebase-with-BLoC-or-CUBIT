import 'package:firebase_auth/firebase_auth.dart' show User;
import '../../../core/utils_shared/typedef.dart';
import 'shared_data_transfer_objects/_user_dto.dart';

/// 📡 [IProfileRemoteDatabase] — Contract for accessing user data from remote source
//
abstract interface class IProfileRemoteDatabase {
  ///-------------------------------------------
  //
  /// 🔍 Fetches [UserDTO] by UID from remote
  ResultFuture<UserDTO> getUserDTO(String uid);
  //
  /// 🧱 Ensure profile exists in Firestore after sign in/up
  ResultFuture<void> ensureUserProfileCreated(User user);
  //
}
