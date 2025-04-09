part of 'auth_bloc.dart';

/// 📌 Base class for all [AuthEvent]s
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// 🔄 Triggered when Firebase user changes (login/logout)
final class AuthStateChangedEvent extends AuthEvent {
  final fb_auth.User? user;

  const AuthStateChangedEvent({this.user});

  @override
  List<Object?> get props => [user];
}

/// 🔐 Request to sign out
final class SignoutRequestedEvent extends AuthEvent {}
