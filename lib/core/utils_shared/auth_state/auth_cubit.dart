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

  /// 🔁 Handles Firebase user changes → updates [AuthState]
  void _onAuthStateChanged(User? user) {
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

  /// 🔄 Перезавантажує поточного користувача з Firebase
  Future<void> reloadUser() async {
    try {
      // Отримуємо поточного користувача
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      // Перезавантажуємо користувача з Firebase
      await currentUser.reload();

      // Отримуємо оновлені дані
      final updatedUser = FirebaseAuth.instance.currentUser;
      if (updatedUser == null) return;

      // Створюємо новий стан з оновленими даними
      final updatedState = state.copyWith(
        user: updatedUser, // або маппінг у ваш User model
        authStatus:
            updatedUser.emailVerified
                ? AuthStatus.authenticated
                : AuthStatus.unauthenticated,
      );

      emit(updatedState);

      debugPrint(
        '🔄 User reloaded. Email verified: ${updatedUser.emailVerified}',
      );
    } catch (e) {
      debugPrint('❌ Error reloading user: $e');
      // Опціонально: emit помилку
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
