import 'dart:async';
import 'package:flutter/foundation.dart';
import 'auth_state_cubit/auth_cubit.dart';

/// 🔄 [AuthStateRefresher] — Triggers GoRouter rebuilds on auth/state changes
/// ✅ Listens to any `Stream` (e.g. Bloc, Cubit)
/// 🔔 Calls `notifyListeners()` to update navigation when stream emits

base class AuthStateRefresher extends ChangeNotifier {
  ///-----------------------------------------------

  AuthStateRefresher(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  /// 🧽 Disposes subscription on widget tree unmount
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  //
}

////

////

class AuthCubitAdapter extends ChangeNotifier {
  ///-----------------------------------------

  final AuthCubit cubit;
  late final StreamSubscription _subscription;

  AuthCubitAdapter(this.cubit) {
    _subscription = cubit.stream.listen((_) => notifyListeners());
  }

  @override
  Future<void> dispose() {
    super.dispose();
    return _subscription.cancel();
  }

  //
}
