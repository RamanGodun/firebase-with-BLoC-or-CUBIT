import '../../../core/general_utils/typedef.dart';
import '../../../core/shared_layers/shared_data_transfer_objects/_user_dto.dart';

/// 📡 [ProfileRemoteDataSource] — Contract for accessing user data from remote source
abstract interface class ProfileRemoteDataSource {
  /// 🔍 Fetches [UserDTO] by UID from remote
  ResultFuture<UserDTO> getUserDTO(String uid);
}
