import 'dart:async';

/// 🧠 [OverlayStateBridge] — Reactive bridge for broadcasting overlay activity status
/// ✅ Used to notify external listeners (e.g. OverlayStatusCubit) from inside [OverlayDispatcher]
abstract final class OverlayStateBridge {
  OverlayStateBridge._();

  static final StreamController<bool> _controller =
      StreamController<bool>.broadcast();

  /// 🔁 Stream to listen for overlay active/inactive state changes
  static Stream<bool> get stream => _controller.stream;

  /// 📡 Used by [OverlayDispatcher] to notify observers
  static void notify(bool isActive) => _controller.add(isActive);

  /// 🧼 Optional cleanup
  static Future<void> dispose() async {
    await _controller.close();
  }
}
