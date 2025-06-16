import 'package:firebase_with_bloc_or_cubit/features/profile/data/shared_data_transfer_objects/user_dto_x.dart';
import '../../domain/shared_entities/_user.dart';
import '_user_dto.dart';

/// 🔁 [UserDTOListExtension] — List-level helper for [UserDTO] → [UserEntity]
/// ✅ Useful for bulk transformations

extension UserDTOListExtension on List<UserDTO> {
  //--------------------------------------

  List<UserEntity> toEntities() => map((dto) => dto.toEntity()).toList();

  //
}
