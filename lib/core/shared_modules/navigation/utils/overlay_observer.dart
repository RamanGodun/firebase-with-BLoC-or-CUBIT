import 'package:flutter/widgets.dart';
import '../../overlay/dispatcher.dart';
// ✅ Goal: Automatically clear active overlays when navigating between screens

/// 🧩 [OverlayNavigatorObserver] — Observes navigation events to clear overlays
/// 📌 Use in GoRouter via `navigatorBuilder`, or wrap `MaterialApp.router`
final class OverlayNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    OverlayDispatcher.instance.clearAll();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    OverlayDispatcher.instance.clearAll();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    OverlayDispatcher.instance.clearAll();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    OverlayDispatcher.instance.clearAll();
  }
}
