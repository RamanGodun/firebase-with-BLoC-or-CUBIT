import '../../shared_data/data_transfer_objects/user_dto.dart';
import '../../../../core/utils/typedef.dart';
import 'user.dart';

/*
extension UserX on User {
  static User empty() => const User(id: 0, createdAt: '', name: '', avatar: '');
}
 */

extension UserX on User {
  static User empty() => const User(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: 0,
    rank: '',
  );
}

/*
extension UserMapper on UserDTO {
  User toEntity() =>
      User(id: id, createdAt: createdAt, name: name, avatar: avatar);
}


extension UserEntityMapper on User {
  UserDTO toDTO() =>
      UserDTO(id: id, createdAt: createdAt, name: name, avatar: avatar);
}
 */

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

/*
extension UserCopyWith on User {
  User copyWith({int? id, String? createdAt, String? name, String? avatar}) {
    return User(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }
}
 */

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

extension UserDTOExtension on UserDTO {
  DataMap toJsonMap() => toMap();
}

extension UserDTOListX on List<UserDTO> {
  List<User> toEntities() => map((dto) => dto.toEntity()).toList();
}

extension UserListDTOExtension on List<User> {
  List<UserDTO> toDTOs() => map((e) => e.toDTO()).toList();
}

extension NullableUserDTOExtension on UserDTO? {
  bool get isNullOrEmpty => this == null || this!.id.isEmpty;

  ///
}
