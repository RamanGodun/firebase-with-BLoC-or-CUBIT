import 'package:equatable/equatable.dart';

/// 👤 [User] — Domain Entity representing a user in the system
/// ✅ Immutable, comparable via [Equatable], used only in domain layer
//----------------------------------------------------------------

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileImage;
  final int point;
  final String rank;

  /// 🧱 Creates a new [User] instance
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.point,
    required this.rank,
  });

  @override
  List<Object?> get props => [id, name, email, profileImage, point, rank];

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, point: $point, rank: $rank)';

  ///
}
