import 'package:flutter/widgets.dart';
import '../../../../app_bootstrap_and_config/di_container/di_container_init.dart';
import '../../overlays/overlay_dispatcher/_overlay_dispatcher.dart';

/// 🧭 [OverlaysCleanerWithinNavigation] — Clears all overlays on navigation events
/// ✅ Ensures that overlays (banners, snackbars, dialogs) do not persist
/// ✅ Works with GoRouter, Navigator 2.0, or traditional Navigator
//
final class OverlaysCleanerWithinNavigation extends NavigatorObserver {
  ///----------------------------------------------------------

  /// 📦 Reference to the overlay dispatcher (via GetIt)
  OverlayDispatcher get overlaysDispatcher => di<OverlayDispatcher>();
  //

  /// 🔁 Called when a new route is pushed onto the navigator
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on push
  }

  /// 🔁 Called when a route is popped from the navigator
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on pop
  }

  /// 🔁 Called when a route is removed without being completed
  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on remove
  }

  /// 🔁 Called when a route is replaced with another
  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    overlaysDispatcher.clearAll(); // 🧹 Clear overlays on replace
  }

  //
}
