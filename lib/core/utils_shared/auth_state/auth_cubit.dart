import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_state.dart';

/// 🔐 [AuthCubit] — Manages authentication state using Firebase [userStream].
/// ✅ Emits `authenticated` / `unauthenticated` states reactively (SRP)
/// ✅ signOut logic is in separate [SignOutCubit]

final class AuthCubit extends Cubit<AuthState> {
  ///------------------------------------------

  final Stream<User?> userStream;
  late final StreamSubscription<User?> _authSubscription;

  /// 🧱 Initializes [AuthCubit] with Firebase user stream
  /// 🧭 Listens to auth state changes and emits updates
  AuthCubit({required this.userStream}) : super(AuthState.unknown()) {
    _authSubscription = userStream.listen(_onAuthStateChanged);
  }
  //

  /// 🔁 Handles Firebase user changes → updates [AuthState]
  void _onAuthStateChanged(User? user) {
    final newStatus =
        user != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    //
    debugPrint(
      '🟡 [AuthCubit] FirebaseAuth stream event received.\n'
      'User: ${user?.uid ?? "null"} | Verified: ${user?.emailVerified} | NewStatus: $newStatus',
    );
    //
    emit(state.copyWith(authStatus: newStatus, user: user));
  }
  //

  /// 🔄 Перезавантажує поточного користувача з Firebase
  Future<void> reloadUser() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        debugPrint('⚠️ [AuthCubit] reloadUser: currentUser is null');
        return;
      }
      //
      await currentUser.reload();
      final updatedUser = FirebaseAuth.instance.currentUser;
      //
      if (updatedUser == null) {
        debugPrint(
          '⚠️ [AuthCubit] reloadUser: updatedUser is null after reload',
        );
        return;
      }
      //
      final newStatus =
          updatedUser.emailVerified
              ? AuthStatus.authenticated
              : AuthStatus.unauthenticated;
      //
      debugPrint(
        '🔄 [AuthCubit] reloadUser completed.\n'
        'User: ${updatedUser.uid} | Verified: ${updatedUser.emailVerified} | NewStatus: $newStatus',
      );
      //
      emit(state.copyWith(user: updatedUser, authStatus: newStatus));
    } catch (e) {
      debugPrint('❌ [AuthCubit] reloadUser error: $e');
    }
  }

  /// 🧼 Cancels auth stream subscription on Cubit close
  @override
  Future<void> close() {
    _authSubscription.cancel();
    return super.close();
  }

  //
}
