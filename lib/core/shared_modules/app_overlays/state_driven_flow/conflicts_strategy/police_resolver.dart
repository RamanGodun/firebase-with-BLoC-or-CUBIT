import '../../core/overlay_enums.dart';
import '../overlay_entries/_overlay_entries.dart';

/// 🎯 [OverlayPolicyResolver] — Static resolver for overlay conflict and dismiss policies
/// ✅ Centralizes logic for priority-based replacement and dismissibility behavior
///----------------------------------------------------------------

final class OverlayPolicyResolver {
  const OverlayPolicyResolver._();

  /// 🔁 Determines if the [next] overlay should replace the [current] one
  /// based on the replacement [OverlayReplacePolicy].
  /// Returns `true` if replacement is allowed according to policy logic.
  static bool shouldReplaceCurrent(
    OverlayUIEntry next,
    OverlayUIEntry current,
  ) {
    final n = next.strategy;
    final c = current.strategy;

    ///
    return switch (n.policy) {
      //
      // Always replace current overlay, regardless of type or category
      OverlayReplacePolicy.forceReplace => true,

      // Replace if both overlays belong to the same category (e.g., dialog)
      OverlayReplacePolicy.forceIfSameCategory => n.category == c.category,

      // Replace only if next overlay has higher priority
      OverlayReplacePolicy.forceIfLowerPriority =>
        n.priority.index > c.priority.index,

      // Do not show if same type of overlay is already visible
      OverlayReplacePolicy.dropIfSameType =>
        next.runtimeType == current.runtimeType,

      // Never replace immediately; queue instead
      OverlayReplacePolicy.waitQueue => false,
    };
  }

  /// ⏳ Determines if the incoming overlay should wait instead of showing immediately
  /// Relevant for [OverlayReplacePolicy.waitQueue].
  static bool shouldWait(OverlayUIEntry entry) =>
      entry.strategy.policy == OverlayReplacePolicy.waitQueue;

  /// 📌 Maps a `bool` flag to corresponding [OverlayDismissPolicy].
  /// Returns [dismissible] if `true`, otherwise [persistent].
  static OverlayDismissPolicy resolveDismissPolicy(bool isDismissible) =>
      isDismissible
          ? OverlayDismissPolicy.dismissible
          : OverlayDismissPolicy.persistent;

  ///
}
