import 'user.dart';
import '../../shared_data/shared_data_transfer_objects/user_dto.dart';

/// 🧩 [UserExt] — Instance methods on [User]
/// - 🧱 `copyWith()`
/// - 🔄 `toDTO()`
/// - ❓ `isEmpty`, `isNotEmpty`
extension UserExt on User {
  /// 🧱 Allows `.copyWith()` on [User]
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImage,
    int? point,
    String? rank,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      point: point ?? this.point,
      rank: rank ?? this.rank,
    );
  }

  /// 🔄 Converts [User] to [UserDTO]
  UserDTO toDTO() => UserDTO(
    id: id,
    name: name,
    email: email,
    profileImage: profileImage,
    point: point,
    rank: rank,
  );

  /// ❓ Returns `true` if user is considered empty
  bool get isEmpty => id.isEmpty;

  /// ❓ Returns `true` if user is valid/non-empty
  bool get isNotEmpty => !isEmpty;
}
