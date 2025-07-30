part of '_overlay_entries_registry.dart';

/// 🪧 [BannerOverlayEntry] — State-driven platform-aware banner
///   - Used by [OverlayDispatcher] for automatic banner rendering
///   - Defines conflict strategy, priority, and dismissibility
///   - Renders animated [AppBanner] via [AnimationHost]
///   - Called by Dispatcher during overlay insertion
//
final class BannerOverlayEntry extends OverlayUIEntry {
  ///-----------------------------------------------
  //
  final Widget widget;
  final bool isError; // ❗ Marks as an error (affects priority & category)
  final OverlayPriority priority;
  // 🔐 Dismiss policy (persistent or dismissible)
  @override
  final OverlayDismissPolicy? dismissPolicy;

  BannerOverlayEntry({
    required this.widget,
    this.isError = false,
    required this.priority,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });
  //

  /// ⚙️ Defines how this entry behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: priority,
    policy: switch (priority) {
      OverlayPriority.critical => OverlayReplacePolicy.forceReplace,
      OverlayPriority.high => OverlayReplacePolicy.forceIfLowerPriority,
      OverlayPriority.normal => OverlayReplacePolicy.forceIfSameCategory,
      OverlayPriority.userDriven => OverlayReplacePolicy.waitQueue,
    },
    category: isError ? OverlayCategory.error : OverlayCategory.banner,
  );

  /// 🫥 Enables tap passthrough to UI underneath (non-blocking UX)
  @override
  bool get tapPassthroughEnabled => true;

  /// 🧱 Builds and animates the banner via [AnimationEngine]
  @override
  Widget buildWidget() => widget;

  ///
  @override
  void onAutoDismissed() {
    // 🎯 Make some actions after dismiss or
    // Track/log auto-dismissed overlay if needed
  }

  //
}
