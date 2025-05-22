import 'package:flutter/widgets.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '_overlay_dispatcher.dart';

// ✅ Goal: Automatically clear active overlays when navigating between screens
/// 🧩 [OverlayNavigatorObserver] — Observes navigation events to clear overlays
/// 📌 Use in GoRouter via `navigatorBuilder`, or wrap `MaterialApp.router`
///----------------------------------------------------------------

final class OverlayNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    di<OverlayDispatcher>().clearAll();
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    di<OverlayDispatcher>().clearAll();
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    di<OverlayDispatcher>().clearAll();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    di<OverlayDispatcher>().clearAll();
  }
}
