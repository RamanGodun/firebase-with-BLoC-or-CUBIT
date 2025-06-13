import 'package:cloud_firestore/cloud_firestore.dart';
import '../../general_utils/typedef.dart';
import '_user_dto.dart';

/// 🧰 [UserDTOUtilsX] — Static utilities for creating [UserDTO]
/// ✅ Use case: Firestore mapping, default user creation
//----------------------------------------------------------------

extension UserDTOUtilsX on UserDTO {
  /// 🔄 Creates [UserDTO] from Firestore document snapshot
  static UserDTO fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
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

  /// 🔄 Creates [UserDTO] from raw Firestore [Map]
  static UserDTO fromMap(DataMap map, {required String id}) => UserDTO(
    id: id,
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    profileImage: map['profileImage'] ?? '',
    point: map['point'] ?? 0,
    rank: map['rank'] ?? '',
  );

  /// 🆕 Creates a new default [UserDTO] for registration
  static UserDTO newUser({
    required String id,
    required String name,
    required String email,
  }) => UserDTO(
    id: id,
    name: name,
    email: email,
    profileImage: 'https://picsum.photos/300',
    point: 0,
    rank: 'bronze',
  );

  ///
}
