part of 'profile_page_cubit.dart';

/// 📄 [ProfileState] — Stores current profile status and data
/// ✅ Holds failure as [Consumable] to ensure one-time UI display
//----------------------------------------------------------------

final class ProfileState extends Equatable {
  final ProfileStatus status;
  final User user;
  final Consumable<FailureUIModel>? failure;

  /// 🧱 Initial constructor
  const ProfileState({required this.status, required this.user, this.failure});

  /// 🆕 Factory constructor for initial state
  factory ProfileState.initial() =>
      ProfileState(status: ProfileStatus.initial, user: UserUtilsExt.empty());

  /// 🔁 Returns new instance with optional overridden fields
  ProfileState copyWith({
    final ProfileStatus? status,
    final User? user,
    final Consumable<FailureUIModel>? failure,
  }) {
    return ProfileState(
      status: status ?? this.status,
      user: user ?? this.user,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [status, user, failure];
}

/// 📍 [ProfileStatus] — Represents profile loading lifecycle
enum ProfileStatus { initial, loading, loaded, error }
