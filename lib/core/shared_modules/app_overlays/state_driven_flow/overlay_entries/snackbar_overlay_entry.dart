part of '_overlay_entries.dart';

/// 🍞 [SnackbarOverlayEntry] — State-driven platform-aware snackbar
/// - Used by [OverlayDispatcher] for automatic snackbar rendering
/// - Encapsulates priority, dismiss policy, and visual props
/// - Built via [AnimationHost] and animated per platform
/// - Called by Dispatcher during overlay insertion
// ----------------------------------------------------------------------

final class SnackbarOverlayEntry extends OverlayUIEntry {
  final Widget widget;
  final bool isError; // ❗ Marks as an error (affects strategy and priority)
  // 🔐 Dismiss policy (persistent or dismissible)
  @override
  final OverlayDismissPolicy dismissPolicy;

  SnackbarOverlayEntry({
    required this.widget,
    this.isError = false,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  /// ⚙️ Defines how this entry behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.high,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.forceIfLowerPriority,
    category: isError ? OverlayCategory.error : OverlayCategory.snackbar,
  );

  /// 🫥 Enables tap passthrough to UI underneath (non-blocking UX)
  @override
  bool get tapPassthroughEnabled => true;

  /// 🧱 Builds and animates the snackbar via [AnimationEngine]
  @override
  Widget buildWidget() => widget;

  @override
  void onAutoDismissed() {
    // 🎯 Make some actions after dismiss or
    // Track/log auto-dismissed overlay if needed
  }
  //
}
