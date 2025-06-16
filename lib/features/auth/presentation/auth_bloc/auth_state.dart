part of 'auth_bloc.dart';

/// 🔒 [AuthStatus] — Represents current authentication state
/// - `unknown`: Initial state (e.g. splash screen)
/// - `authenticated`: User is signed in
/// - `unauthenticated`: User is signed out

enum AuthStatus { unknown, authenticated, unauthenticated }

/// 🧾 [AuthState] — Bloc state that holds current auth status & user

final class AuthState extends Equatable {
  //------------------------------------
  final AuthStatus authStatus;
  final fb_auth.User? user;

  /// ✅ Constructor for [AuthState]
  const AuthState({required this.authStatus, this.user});

  /// 🆕 Factory: initial unknown state (e.g. at app launch)
  factory AuthState.unknown() =>
      const AuthState(authStatus: AuthStatus.unknown);

  /// 🔁 Creates a new state with optional overrides
  AuthState copyWith({AuthStatus? authStatus, fb_auth.User? user}) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
    //
  }

  @override
  List<Object?> get props => [authStatus, user];

  @override
  String toString() => 'AuthState(authStatus: $authStatus, user: $user)';

  //
}
