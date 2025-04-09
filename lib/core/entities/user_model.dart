import 'package:equatable/equatable.dart';

/// 📦 [User] — Domain Entity, provided via [Equatable].
/// Immutable model that represents the authenticated user inside the app.
class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String profileImage;
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

  /// 🧱 Initial empty user (used for placeholders or loading state)
  factory User.initial() => const User(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: -1,
    rank: '',
  );

  /// 🔍 Equality based on all fields
  @override
  List<Object> get props => [id, name, email, profileImage, point, rank];
}
