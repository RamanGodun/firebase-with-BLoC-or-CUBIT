import '../../../core/utils/typedef.dart';
import '../../shared/shared_data/shared_data_transfer_objects/user_dto.dart';

/// 📡 [ProfileRemoteDataSource] — Contract for accessing user data from remote source
abstract class ProfileRemoteDataSource {
  /// 🔍 Fetches [UserDTO] by UID from remote
  ResultFuture<UserDTO> getUserDTO(String uid);
}
