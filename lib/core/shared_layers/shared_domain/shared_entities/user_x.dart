import '_user.dart';
import '../../shared_data_transfer_objects/_user_dto.dart';

/// 🔁 [UserExt] — Extension on [User] with transformation and utility methods
extension UserExt on User {
  /// 🧱 Converts [User] → [UserDTO] (for persistence or transfer)
  UserDTO toDTO() => UserDTO(
    id: id,
    name: name,
    email: email,
    profileImage: profileImage,
    point: point,
    rank: rank,
  );

  /// 🧱 Allows `.copyWith()` on [User] entity (immutability support)
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

  /// ❓ Checks if user is considered empty
  bool get isEmpty => id.isEmpty;

  /// ✅ Opposite of [isEmpty]
  bool get isNotEmpty => id.isNotEmpty;
}
