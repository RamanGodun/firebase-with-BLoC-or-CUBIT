import 'dart:convert';
import '../../general_utils/typedef.dart';
import '_user_dto.dart';
import '../shared_domain/shared_entities/_user.dart';

/// 🔄 [UserDTOExt] — Instance-level helpers for [UserDTO]
/// ✅ Converts to entity or JSON (for logic or API usage)

extension UserDTOExt on UserDTO {
  //----------------------------

  /// 🔄 Converts [UserDTO] → Domain [UserEntity] entity
  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    email: email,
    profileImage: profileImage,
    point: point,
    rank: rank,
  );

  /// 📦 Converts current [UserDTO] → raw [Map]
  DataMap toJsonMap() => {
    'name': name,
    'email': email,
    'profileImage': profileImage,
    'point': point,
    'rank': rank,
  };

  /// 📦 Converts current [UserDTO] → JSON string
  String toJson() => jsonEncode(toJsonMap());

  /// ❓ Returns true if DTO is empty (based on ID)
  bool get isEmpty => id.isEmpty;

  /// ✅ Negated [isEmpty]
  bool get isNotEmpty => !isEmpty;

  //
}

////

////

/// 🔁 [UserDTOListExt] — List-level helper for [UserDTO] → [UserEntity]
/// ✅ Useful for bulk transformations

extension UserDTOListExt on List<UserDTO> {
  //--------------------------------------

  List<UserEntity> toEntities() => map((dto) => dto.toEntity()).toList();

  //
}
