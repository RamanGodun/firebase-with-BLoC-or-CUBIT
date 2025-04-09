import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/entities/user_model.dart';

/// 📦 [UserDto] — Data Transfer Object for [User] entity.
/// Used for serialization/deserialization between Firestore and domain layer.
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

  // ────────────────────────────────────────────────────────────────────
  // 🔄 FROM FIRESTORE
  // ────────────────────────────────────────────────────────────────────

  /// 🧩 Creates a [UserDto] from Firestore document
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

  // ────────────────────────────────────────────────────────────────────
  // 🔁 TO FIRESTORE
  // ────────────────────────────────────────────────────────────────────

  /// 🔁 Converts this [UserDto] to Firestore-compatible map
  Map<String, dynamic> toMap() => {
    'name': name,
    'email': email,
    'profileImage': profileImage,
    'point': point,
    'rank': rank,
  };

  // ────────────────────────────────────────────────────────────────────
  // 🔄 DOMAIN ↔ DTO MAPPINGS
  // ────────────────────────────────────────────────────────────────────

  /// 🔁 Converts [UserDto] to domain [User]
  User toDomain() => User(
    id: id,
    name: name,
    email: email,
    profileImage: profileImage,
    point: point,
    rank: rank,
  );

  /// 🔁 Converts domain [User] to [UserDto]
  static UserDto fromDomain(User user) => UserDto(
    id: user.id,
    name: user.name,
    email: user.email,
    profileImage: user.profileImage,
    point: user.point,
    rank: user.rank,
  );

  // ────────────────────────────────────────────────────────────────────
  // 🆕 FACTORY
  // ────────────────────────────────────────────────────────────────────

  /// 🆕 Creates a new default [UserDto] with basic values
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
