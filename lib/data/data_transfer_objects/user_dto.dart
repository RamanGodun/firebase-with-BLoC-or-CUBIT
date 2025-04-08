import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/entities/user_model.dart';

/// DTO (Data Transfer Object) for serializing/deserializing [User]
class UserDto {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int point;
  final String rank;

  const UserDto({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  /// Deserialize from Firestore document
  factory UserDto.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw FirebaseException(
        plugin: 'cloud_firestore',
        code: 'invalid-data',
        message: 'No user data found in Firestore document',
      );
    }

    return UserDto(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profileImage: data['profileImage'] ?? '',
      point: data['point'] ?? 0,
      rank: data['rank'] ?? '',
    );
  }

  /// Serialize to Firestore-compatible map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'profileImage': profileImage,
      'point': point,
      'rank': rank,
    };
  }

  /// Convert DTO to domain [User]
  User toDomain() {
    return User(
      id: id,
      name: name,
      email: email,
      profileImage: profileImage,
      point: point,
      rank: rank,
    );
  }

  /// Convert domain [User] to DTO
  static UserDto fromDomain(User user) {
    return UserDto(
      id: user.id,
      name: user.name,
      email: user.email,
      profileImage: user.profileImage,
      point: user.point,
      rank: user.rank,
    );
  }

  ///
  // user_dto.dart
  factory UserDto.newUser({
    required String id,
    required String name,
    required String email,
  }) {
    return UserDto(
      id: id,
      name: name,
      email: email,
      profileImage: 'https://picsum.photos/300',
      point: 0,
      rank: 'bronze',
    );
  }

  ///
}
