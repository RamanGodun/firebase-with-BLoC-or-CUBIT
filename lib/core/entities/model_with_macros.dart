/*
  ✅ Макроси для автоматичної генерації рутинного коду

  @autoSerializable
  Генерує fromJson() / toJson()

  @autoCopyable
  Генерує copyWith()

  @autoValidated
  Генерує валідацію згідно з анотаціями (@Min, @NotEmpty, etc.)
*/
/*

@autoSerializable
@autoCopyable
@autoValidated
class User extends Equatable {
  final String id;

  @NotEmpty()
  final String name;

  @Email()
  final String email;

  final String profileImage;

  @Min(0)
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

  /// ✅ Створити з Firestore DocumentSnapshot
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

  /// ✅ Початковий пустий юзер
  factory User.initial() => const User(
    id: '',
    name: '',
    email: '',
    profileImage: '',
    point: 0,
    rank: '',
  );

  @override
  List<Object> get props => [id, name, email, profileImage, point, rank];

  @override
  String toString() =>
      'User(id: $id, name: $name, email: $email, point: $point, rank: $rank)';
}

 */
