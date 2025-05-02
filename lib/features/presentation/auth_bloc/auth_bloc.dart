import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// 🔐 [AuthBloc] — Handles authentication state and Firebase auth stream.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  late final StreamSubscription<fb_auth.User?> _authSubscription;

  AuthBloc({required this.authRepository}) : super(AuthState.unknown()) {
    _authSubscription = authRepository.user.listen(
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
    if (event.user != null) {
      emit(
        state.copyWith(authStatus: AuthStatus.authenticated, user: event.user),
      );
    } else {
      emit(state.copyWith(authStatus: AuthStatus.unauthenticated, user: null));
    }
  }

  /// 🚪 Handles user sign-out
  Future<void> _onSignoutRequested(
    SignoutRequestedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await authRepository.signout();
  }

  /// 🧼 Dispose the subscription
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }
}
