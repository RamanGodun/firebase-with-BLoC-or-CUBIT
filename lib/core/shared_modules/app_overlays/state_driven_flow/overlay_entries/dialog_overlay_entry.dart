part of '_overlay_entries.dart';

/// 💬 [DialogOverlayEntry] — DTO for Info/Error dialogs in state-driven flows
/// ✅ Used by [OverlayDispatcher] to build animated platform dialogs
// ----------------------------------------------------------------------

final class DialogOverlayEntry extends OverlayUIEntry {
  final Widget widget;
  final bool isError; // ❗ Marks as an error (affects strategy and priority)
  @override
  final OverlayDismissPolicy? dismissPolicy;

  const DialogOverlayEntry({
    required this.widget,
    this.isError = false,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  /// ⚙️ Defines how this entry behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.normal,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.waitQueue,
    category: isError ? OverlayCategory.error : OverlayCategory.dialog,
  );

  ///
  @override
  Widget buildWidget() {
    return widget;
  }

  @override
  void onAutoDismissed() {
    // 🎯 Make some actions after dissmiss or
    // Track/log auto-dismissed overlay if needed
  }

  ///
}
