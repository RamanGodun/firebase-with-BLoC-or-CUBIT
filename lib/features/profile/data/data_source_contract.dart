import '../../../core/utils_shared/typedef.dart';
import '../../../core/shared_data_layer/shared_data_transfer_objects/_user_dto.dart';

/// 📡 [IProfileRemoteDatabase] — Contract for accessing user data from remote source
//
abstract interface class IProfileRemoteDatabase {
  ///-------------------------------------------
  //
  /// 🔍 Fetches [UserDTO] by UID from remote
  ResultFuture<UserDTO> getUserDTO(String uid);
  //
  /// 🧱 Create profile if not exists in Firestore
  ResultFuture<void> createUserProfile(String uid);
  //
}
