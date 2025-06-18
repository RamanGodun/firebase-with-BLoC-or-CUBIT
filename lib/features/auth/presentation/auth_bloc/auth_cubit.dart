// ✅ Видалено: import '../../domain/use_cases/sign_out.dart';

import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

part 'auth_state.dart';

/// 🔐 [AuthCubit] — Manages auth state using Firebase user stream
/// ✅ Emits `authenticated` / `unauthenticated` states
/// ✅ signOut логіка винесена в окремий [SignOutCubit]

final class AuthCubit extends Cubit<AuthState> {
  //----------------------------------------------------

  final Stream<fb_auth.User?> userStream;
  late final StreamSubscription<fb_auth.User?> _authSubscription;

  /// 🧱 Initializes [AuthCubit] with Firebase user stream
  /// 🧭 Listens to auth state changes and emits updates
  AuthCubit({required this.userStream}) : super(AuthState.unknown()) {
    _authSubscription = userStream.listen(_onAuthStateChanged);
  }

  /// 🔁 Handles Firebase user changes → updates auth status and user
  void _onAuthStateChanged(fb_auth.User? user) {
    emit(
      state.copyWith(
        authStatus:
            user != null
                ? AuthStatus.authenticated
                : AuthStatus.unauthenticated,
        user: user,
      ),
    );
  }

  /// 🧼 Cancels auth stream subscription on Cubit close
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  //
}
