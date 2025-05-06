import 'user.dart';
import '../../shared_data/shared_data_transfer_objects/user_dto.dart';

/// 🧰 [UserUtilizeExt] — Static-like utilities for creating [User]
/// - 🔰 `empty()`
/// - 🔄 `fromDTO()`
/// - 🔄 `fromDTOList()`
extension UserUtilizeExt on User {
  /// 🔰 Returns a predefined empty user
  static User empty() => const User(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: 0,
    rank: '',
  );

  /// 🔄 Converts [UserDTO] → [User]
  static User fromDTO(UserDTO dto) => User(
    id: dto.id,
    name: dto.name,
    email: dto.email,
    profileImage: dto.profileImage,
    point: dto.point,
    rank: dto.rank,
  );

  /// 🔄 Converts [List<UserDTO>] → [List<User>]
  static List<User> fromDTOList(List<UserDTO> list) =>
      list.map(fromDTO).toList();
}
