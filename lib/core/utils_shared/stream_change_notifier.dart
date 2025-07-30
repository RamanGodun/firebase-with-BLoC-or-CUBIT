import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart' show ChangeNotifier;

/// 🔄 [StreamChangeNotifier] — Bridges any [Stream] to [ChangeNotifier] for imperative listeners
/// ✅ Used for cases where you need to notify imperative listeners (e.g., GoRouter.refreshListenable)
/// ✅ Compatible with any [Stream<T>] — Riverpod, Firebase, etc.
//
final class StreamChangeNotifier<T> extends ChangeNotifier {
  ///----------------------------------------------------
  //
  /// 🔗 Subscription to provided stream
  StreamSubscription<T>? _subscription;

  /// 🏗️ Subscribes to [stream] and notifies listeners on each event
  StreamChangeNotifier(Stream<T> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  /// 🧹 Cancels subscription on dispose to prevent leaks
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  //
}
