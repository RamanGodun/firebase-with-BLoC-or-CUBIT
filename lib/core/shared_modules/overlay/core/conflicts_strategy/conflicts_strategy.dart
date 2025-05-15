library;

/// 🎯 Defines core strategy types for overlay conflict resolution,
/// used to determine behavior when multiple overlays are triggered.
///----------------------------------------------------------------

/// 🔺 Priority levels for overlays (used for conflict resolution)
// ⬇️ Least important, can be dropped easily
// 🔼 Important, takes precedence over lower ones
enum OverlayPriority { low, normal, high, critical }

/// 🏷️ Categorizes overlays by their visual or functional purpose
enum OverlayCategory { loader, banner, dialog, snackbar, otherCustom, error }

/// 🔐 Defines whether overlay can be dismissed externally
enum OverlayDismissPolicy {
  dismissible, // ✋ Tappable/cancellable
  persistent, // 🔒 Stays until dismissed programmatically
}

/// 🤝 Rules for resolving overlay collisions or duplicates
enum OverlayReplacePolicy {
  waitQueue, // ⏳ Wait in queue until current one is dismissed
  forceReplace, // 🔁 Always replace current overlay
  forceIfSameCategory, // 🔁 Replace if same category (e.g. two dialogs)
  forceIfLowerPriority, // 🔁 Replace only if new has higher priority
  dropIfSameType, // 🚫 Ignore if same type already visible
}

/// 🧠 [OverlayConflictStrategy] — Strategy object for each overlay that
/// defines its replacement logic and category identification.
class OverlayConflictStrategy {
  final OverlayPriority priority;
  final OverlayReplacePolicy policy;
  final OverlayCategory category;

  const OverlayConflictStrategy({
    required this.priority,
    required this.policy,
    required this.category,
  });
}
