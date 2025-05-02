part of 'auth_bloc.dart';

/// 🔒 Represents the current auth status
enum AuthStatus { unknown, authenticated, unauthenticated }

/// 🧾 [AuthState] — Holds the authentication state
class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fb_auth.User? user;

  const AuthState({required this.authStatus, this.user});

  /// 🆕 Initial unknown state (used during splash screen)
  factory AuthState.unknown() =>
      const AuthState(authStatus: AuthStatus.unknown);

  /// 🔁 Create a copy with optional overrides
  AuthState copyWith({AuthStatus? authStatus, fb_auth.User? user}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [authStatus, user];

  @override
  String toString() => 'AuthState(authStatus: $authStatus, user: $user)';
}
