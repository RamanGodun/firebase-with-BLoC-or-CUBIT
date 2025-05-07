part of 'profile_page_cubit.dart';

/// 🧾 [ProfileState] — Represents the current state of the user profile
/// ✅ Holds profile loading status, user entity, and optional failure
/// ✅ Failure is wrapped in [Consumable] to prevent repeated UI consumption
//----------------------------------------------------------------
final class ProfileState extends Equatable {
  final ProfileStatus status;
  final User user;
  final Consumable<Failure>? failure;

  const ProfileState({required this.status, required this.user, this.failure});

  /// 🆕 Empty user, initial status, no failure
  factory ProfileState.initial() => ProfileState(
    status: ProfileStatus.initial,
    user: UserUtilsExt.empty(),
    failure: null,
  );

  /// 🔁 Clones the state with optional updated fields
  ProfileState copyWith({
    ProfileStatus? status,
    User? user,
    Consumable<Failure>? failure,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure,
    );
  }

  /// 🧠 Extracts the error message from failure once (via `consume`)
  String? get errorMessage => failure?.consume()?.uiMessageOrRaw();

  @override
  List<Object?> get props => [status, user, failure];

  @override
  String toString() =>
      'ProfileState(status: $status, user: $user, failure: $failure)';
}

/// 📍 [ProfileStatus] — Represents profile loading lifecycle
//----------------------------------------------------------------
enum ProfileStatus {
  initial, // Idle or not started
  loading, // Currently loading profile
  loaded, // Profile loaded successfully
  error, // Failed to load profile
}
