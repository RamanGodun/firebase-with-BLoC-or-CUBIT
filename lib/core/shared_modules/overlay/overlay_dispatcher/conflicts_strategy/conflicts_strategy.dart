library;

/// Defines core strategy types (priority, policy, category) used in overlay conflict resolution

enum OverlayReplacePolicy {
  waitQueue,
  forceReplace,
  forceIfSameCategory,
  forceIfLowerPriority,
}

enum OverlayPriority { low, normal, high, critical }

enum OverlayCategory {
  bannerTheme,
  bannerError,
  dialog,
  loader,
  snackbar,
  error,
}

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
