import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/use_cases/sign_out.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// 🔐 [AuthBloc] — Manages auth state using Firebase user stream and [SignOutUseCase]
/// ✅ Emits `authenticated` / `unauthenticated` states and handles logout
//----------------------------------------------------------------

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignOutUseCase signOutUseCase;
  final Stream<fb_auth.User?> userStream;
  late final StreamSubscription<fb_auth.User?> _authSubscription;

  /// 🧱 Initializes [AuthBloc] with Firebase user stream
  /// 🧭 Listens to auth state changes and dispatches [AuthStateChangedEvent]
  AuthBloc({required this.signOutUseCase, required this.userStream})
    : super(AuthState.unknown()) {
    _authSubscription = userStream.listen(
      (fb_auth.User? user) => add(AuthStateChangedEvent(user: user)),
    );

    on<AuthStateChangedEvent>(_onAuthStateChanged);
    on<SignoutRequestedEvent>(_onSignoutRequested);
  }

  /// 🔁 Handles [AuthStateChangedEvent] → updates auth status and user
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

  /// 🚪 Handles [SignoutRequestedEvent] → calls [signOutUseCase]
  Future<void> _onSignoutRequested(
    SignoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await signOutUseCase();
  }

  /// 🧼 Cancels auth stream subscription on BLoC close
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  ///
}
