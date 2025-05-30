import '../../shared_data/shared_data_transfer_objects/_user_dto.dart';
import '_user.dart';

/// 🧩 [UserUtilsExt] — Static-like utilities related to [User] creation
extension UserUtilsExt on User {
  /// 🔰 Returns a predefined empty [User] placeholder
  static User empty() => const User(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: 0,
    rank: '',
  );

  /// 🔄 Converts [UserDTO] to [User] entity (factory-style)
  static User fromDTO(UserDTO dto) => User(
    id: dto.id,
    name: dto.name,
    email: dto.email,
    profileImage: dto.profileImage,
    point: dto.point,
    rank: dto.rank,
  );

  /// 🔁 Mass conversion from DTO list to entity list
  static List<User> fromDTOList(List<UserDTO> list) =>
      list.map(fromDTO).toList();

  ///
}
