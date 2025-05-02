import '../../../core/utils/typedef.dart';
import '../../shared/shared_data/shared_data_transfer_objects/user_dto.dart';

abstract class ProfileRemoteDataSource {
  ResultFuture<UserDTO> getUserDTO(String uid);
}
