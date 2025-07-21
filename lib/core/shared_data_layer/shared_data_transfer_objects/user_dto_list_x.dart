import 'package:firebase_with_bloc_or_cubit/core/shared_data_layer/shared_data_transfer_objects/user_dto_x.dart';
import '../../../features/profile/domain/shared_entities/_user.dart';
import '_user_dto.dart';

/// 🔁 [UserDTOListX] — List-level helper for [UserDTO] → [UserEntity]
/// ✅ Useful for bulk transformations

extension UserDTOListX on List<UserDTO> {
  ///----------------------------------
  //
  List<UserEntity> toEntities() => map((dto) => dto.toEntity()).toList();
  //
}
