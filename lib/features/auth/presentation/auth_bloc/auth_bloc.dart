import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import '../../domain/use_cases/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// 🔐 [AuthBloc] — Handles authentication state and Firebase auth stream.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignOutUseCase signOutUseCase;
  final Stream<fb_auth.User?> userStream;
  late final StreamSubscription<fb_auth.User?> _authSubscription;

  AuthBloc({required this.signOutUseCase, required this.userStream})
    : super(AuthState.unknown()) {
    _authSubscription = userStream.listen(
      (fb_auth.User? user) => add(AuthStateChangedEvent(user: user)),
    );

    on<AuthStateChangedEvent>(_onAuthStateChanged);
    on<SignoutRequestedEvent>(_onSignoutRequested);
  }

  /// 🔁 Reacts to user login/logout from Firebase
  void _onAuthStateChanged(
    AuthStateChangedEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        authStatus:
            event.user != null
                ? AuthStatus.authenticated
                : AuthStatus.unauthenticated,
        user: event.user,
      ),
    );
  }

  /// 🚪 Handles user sign-out
  Future<void> _onSignoutRequested(
    SignoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await signOutUseCase();
  }

  /// 🧼 Dispose the subscription
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
