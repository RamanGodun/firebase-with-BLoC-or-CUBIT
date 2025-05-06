part of 'profile_page_cubit.dart';

/// 📍 [ProfileStatus] — Represents profile loading lifecycle
//----------------------------------------------------------------
enum ProfileStatus { initial, loading, loaded, error }

/// 🧾 [ProfileState] — Holds current status, user entity, and optional failure
//----------------------------------------------------------------

final class ProfileState extends Equatable {
  final ProfileStatus status;
  final User user;
  final Failure? failure;

  const ProfileState({required this.status, required this.user, this.failure});

  /// 🆕 Initial state (empty user, no failure)
  @pragma('vm:prefer-inline')
  factory ProfileState.initial() => ProfileState(
    status: ProfileStatus.initial,
    user: UserX.empty(),
    failure: null,
  );

  /// 🔁 Creates a new state with updated fields
  ProfileState copyWith({ProfileStatus? status, User? user, Failure? failure}) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure,
    );
  }

  /// 🧠 Extracts readable message from failure (if exists)
  String? get errorMessage => failure?.uiMessage;

  @override
  List<Object?> get props => [status, user, failure];

  @override
  String toString() =>
      'ProfileState(status: $status, user: $user, failure: $failure)';

  ///
}
