import '../../../core/utils_shared/typedef.dart';
import 'shared_data_transfer_objects/_user_dto.dart';

/// 📡 [ProfileRemoteDataSource] — Contract for accessing user data from remote source

abstract interface class ProfileRemoteDataSource {
  //--------------------------------------------

  /// 🔍 Fetches [UserDTO] by UID from remote
  ResultFuture<UserDTO> getUserDTO(String uid);

  //
}
