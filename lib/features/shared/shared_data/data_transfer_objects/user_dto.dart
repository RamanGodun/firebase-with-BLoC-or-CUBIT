import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/shared_moduls/errors_handling/typedef.dart';
import 'base_dto.dart';

class UserDTO extends BaseDTO with EquatableMixin {
  const UserDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int point;
  final String rank;

  factory UserDTO.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) throw Exception('No user data found in document');
    return UserDTO(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profileImage: data['profileImage'] ?? '',
      point: data['point'] ?? 0,
      rank: data['rank'] ?? '',
    );
  }

  @override
  DataMap toMap() => {
    'name': name,
    'email': email,
    'profileImage': profileImage,
    'point': point,
    'rank': rank,
  };

  factory UserDTO.fromMap(DataMap map, {required String id}) => UserDTO(
    id: id,
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    profileImage: map['profileImage'] ?? '',
    point: map['point'] ?? 0,
    rank: map['rank'] ?? '',
  );

  /// 🆕 Factory: Creates a new user with default values
  factory UserDTO.newUser({
    required String id,
    required String name,
    required String email,
  }) {
    return UserDTO(
      id: id,
      name: name,
      email: email,
      profileImage: 'https://picsum.photos/300',
      point: 0,
      rank: 'bronze',
    );
  }

  @override
  List<Object?> get props => [id, name, email, profileImage, point, rank];

  @override
  String toString() =>
      'UserDTO(id: $id, name: $name, email: $email, point: $point, rank: $rank)';
}
