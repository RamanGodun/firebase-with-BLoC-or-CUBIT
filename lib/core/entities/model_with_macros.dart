/*
  ✅ Macros for auto-generating boilerplate code.

  @autoSerializable
  ➜ Generates `fromJson()` / `toJson()`

  @autoCopyable
  ➜ Generates `copyWith()`

  @autoValidated
  ➜ Generates validation logic based on annotations:
     @Min(), @NotEmpty(), @Email(), etc.
*/

/*
@autoSerializable
@autoCopyable
@autoValidated
*/

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

/// 👤 Immutable domain-level user entity with validation metadata
@immutable
class User extends Equatable {
  final String id;

  // @NotEmpty()
  final String name;

  // @Email()
  final String email;

  final String profileImage;

  // @Min(0)
  final int point;

  final String rank;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  /// 🔄 Factory constructor to create [User] from Firestore [DocumentSnapshot]
  factory User.fromDoc(DocumentSnapshot userDoc) {
    final data = userDoc.data() as Map<String, dynamic>?;

    return User(
      id: userDoc.id,
      name: data?['name'] ?? '',
      email: data?['email'] ?? '',
      profileImage: data?['profileImage'] ?? '',
      point: data?['point'] ?? 0,
      rank: data?['rank'] ?? '',
    );
  }

  /// 🆕 Initial empty user instance
  factory User.initial() => const User(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: 0,
    rank: '',
  );

  /// 🔁 Required for Equatable-based comparison
  @override
  List<Object> get props => [id, name, email, profileImage, point, rank];

  /// 🧾 String representation for debugging/logging
  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, '
      'point: $point, rank: $rank)';
}
