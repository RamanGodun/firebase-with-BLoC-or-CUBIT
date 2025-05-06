import '../../shared_data/shared_data_transfer_objects/user_dto.dart';
import '../../../../core/utils/typedef.dart';
import 'user.dart';

/// 🧩 [UserX] — Static utilities for [User]
extension UserX on User {
  /// 🔰 Returns a predefined empty user, [User] placeholder
  static User empty() => const User(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: 0,
    rank: '',
  );
}

/// 🔄 [UserMapper] — Maps [UserDTO] → [User]
extension UserMapper on UserDTO {
  User toEntity() => User(
    id: id,
    name: name,
    email: email,
    profileImage: profileImage,
    point: point,
    rank: rank,
  );
}

/// 🔄 [UserEntityMapper] — Maps [User] → [UserDTO]
extension UserEntityMapper on User {
  UserDTO toDTO() => UserDTO(
    id: id,
    name: name,
    email: email,
    profileImage: profileImage,
    point: point,
    rank: rank,
  );
}

/// 🧱 [UserCopyWith] — Allows `.copyWith()` on [User]
extension UserCopyWith on User {
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
}

/// 📦 [UserDTOExtension] — Converts to raw [Map] for serialization
extension UserDTOExtension on UserDTO {
  DataMap toJsonMap() => toMap();
}

/// 🔁 [UserDTOListX] — List mapping: [UserDTO] → [User]
extension UserDTOListX on List<UserDTO> {
  List<User> toEntities() => map((dto) => dto.toEntity()).toList();
}

/// 🔁 [UserListDTOExtension] — List mapping: [User] → [UserDTO]
extension UserListDTOExtension on List<User> {
  List<UserDTO> toDTOs() => map((e) => e.toDTO()).toList();
}

/// ❓ [NullableUserDTOExtension] — Null checks
extension NullableUserDTOExtension on UserDTO? {
  bool get isNullOrEmpty => this == null || this!.id.isEmpty;

  ///
}
