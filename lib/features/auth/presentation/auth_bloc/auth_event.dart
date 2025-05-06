part of 'auth_bloc.dart';

/// 📌 [AuthEvent] — Base sealed class for all authentication events
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// 🔄 [AuthStateChangedEvent] — Fired when Firebase user changes (login/logout)
final class AuthStateChangedEvent extends AuthEvent {
  final fb_auth.User? user;

  /// 📥 Accepts a nullable [fb_auth.User] from Firebase stream
  const AuthStateChangedEvent({this.user});

  @override
  List<Object?> get props => [user];
  //
}

/// 🔐 [SignoutRequestedEvent] — Dispatched when user taps sign out
final class SignoutRequestedEvent extends AuthEvent {}
