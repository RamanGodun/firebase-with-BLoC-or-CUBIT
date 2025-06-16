import '../../shared_data_transfer_objects/_user_dto.dart';
import '_user.dart';

/// 🧩 [UserUtilsExt] — Static-like utilities related to [UserEntity] creation

extension UserUtilsExt on UserEntity {
  //---------------------------------

  /// 🔰 Returns a predefined empty [UserEntity] placeholder
  static UserEntity empty() => const UserEntity(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: 0,
    rank: '',
  );

  /// 🔄 Converts [UserDTO] to [UserEntity] entity (factory-style)
  static UserEntity fromDTO(UserDTO dto) => UserEntity(
    id: dto.id,
    name: dto.name,
    email: dto.email,
    profileImage: dto.profileImage,
    point: dto.point,
    rank: dto.rank,
  );

  /// 🔁 Mass conversion from DTO list to entity list
  static List<UserEntity> fromDTOList(List<UserDTO> list) =>
      list.map(fromDTO).toList();

  //
}
