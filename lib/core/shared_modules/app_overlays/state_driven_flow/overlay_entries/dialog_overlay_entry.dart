part of '_overlay_entries.dart';

/// 💬 [DialogOverlayEntry] — DTO for Info/Error dialogs in state-driven flows
/// ✅ Used by [OverlayDispatcher] to build animated platform dialogs
// ----------------------------------------------------------------------

final class DialogOverlayEntry extends OverlayUIEntry {
  final Widget widget;
  final bool isError; // ❗ Marks as an error (affects strategy and priority)
  @override
  final OverlayDismissPolicy? dismissPolicy;
  final OverlayPriority priority;

  DialogOverlayEntry({
    required this.widget,
    this.isError = false,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
    required this.priority,
  });

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
    category: isError ? OverlayCategory.error : OverlayCategory.dialog,
  );

  ///
  @override
  Widget buildWidget() {
    return widget;
  }

  @override
  void onAutoDismissed() {
    // 🎯 Make some actions after dismiss or
    // Track/log auto-dismissed overlay if needed
  }

  ///
}
