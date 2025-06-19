import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart' show immutable;

/// 👤 [UserDTO] — Firebase-ready Data Transfer Object for user model
/// ✅ Represents user data from remote source (Firestore)
/// ✅ Used in data layer only — no logic inside
/// ✅ Immutable, comparable, debug-friendly

@immutable
final class UserDTO with EquatableMixin {
  //------------------------------------

  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int point;
  final String rank;

  const UserDTO({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });
  //

  /// 🧪 Equatable props for value comparison
  @override
  List<Object?> get props => [id, name, email, profileImage, point, rank];

  /// 🧾 Debug-friendly string output
  @override
  String toString() =>
      'UserDTO(id: $id, name: $name, email: $email, point: $point, rank: $rank)';

  //
}
