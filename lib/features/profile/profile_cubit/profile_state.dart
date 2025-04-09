part of 'profile_cubit.dart';

/// 📍 Status of profile loading state
enum ProfileStatus { initial, loading, loaded, error }

/// 🧾 [ProfileState] — Holds the current profile data and status
final class ProfileState extends Equatable {
  final ProfileStatus profileStatus;
  final User user;
  final CustomError error;

  const ProfileState({
    required this.profileStatus,
    required this.user,
    required this.error,
  });

  /// 🆕 Initial state with default empty user and no error
  factory ProfileState.initial() => ProfileState(
        profileStatus: ProfileStatus.initial,
        user: User.initial(),
        error: const CustomError(),
      );

  /// 🔁 Returns a copy of the state with optional updated values
  ProfileState copyWith({
    ProfileStatus? profileStatus,
    User? user,
    CustomError? error,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [profileStatus, user, error];

  @override
  String toString() =>
      'ProfileState(profileStatus: $profileStatus, user: $user, error: $error)';
}