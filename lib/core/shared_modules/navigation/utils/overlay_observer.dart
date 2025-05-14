import 'package:flutter/widgets.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '../../overlay/overlay_dispatcher/overlay_dispatcher_interface.dart';
// ✅ Goal: Automatically clear active overlays when navigating between screens

/// 🧩 [OverlayNavigatorObserver] — Observes navigation events to clear overlays
/// 📌 Use in GoRouter via `navigatorBuilder`, or wrap `MaterialApp.router`
final class OverlayNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    di<IOverlayDispatcher>().clearAll();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    di<IOverlayDispatcher>().clearAll();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    di<IOverlayDispatcher>().clearAll();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    di<IOverlayDispatcher>().clearAll();
  }
}
