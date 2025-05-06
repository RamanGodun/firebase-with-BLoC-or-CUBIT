import 'dart:async';
import 'package:flutter/foundation.dart';

/// 🔄 [GoRouterRefresher] — Triggers GoRouter rebuilds on auth/state changes
/// ✅ Listens to any `Stream` (e.g. Bloc, Cubit)
/// 🔔 Calls `notifyListeners()` to update navigation when stream emits
//--------------------------------------------------------------

base class GoRouterRefresher extends ChangeNotifier {
  GoRouterRefresher(Stream stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription _subscription;

  /// 🧽 Disposes subscription on widget tree unmount
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
