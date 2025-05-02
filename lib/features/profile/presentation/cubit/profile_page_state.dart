part of 'profile_page_cubit.dart';

/// 📍 [ProfileStatus] — represents profile load state
enum ProfileStatus { initial, loading, loaded, error }

/// 🧾 [ProfileState] — Holds current status, user, and error message (if any)
final class ProfileState extends Equatable {
  final ProfileStatus status;
  final User user;
  final Failure? failure;

  const ProfileState({required this.status, required this.user, this.failure});

  /// 🆕 Default empty state
  factory ProfileState.initial() => ProfileState(
    status: ProfileStatus.initial,
    user: User.initial(),
    failure: null,
  );

  /// 🔁 Copy with updated values
  ProfileState copyWith({ProfileStatus? status, User? user, Failure? failure}) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure,
    );
  }

  /// 🪪 Optional user-facing error message
  String? get errorMessage => failure?.uiMessage;

  @override
  List<Object?> get props => [status, user, failure];

  @override
  String toString() =>
      'ProfileState(status: $status, user: $user, failure: $failure)';
}
