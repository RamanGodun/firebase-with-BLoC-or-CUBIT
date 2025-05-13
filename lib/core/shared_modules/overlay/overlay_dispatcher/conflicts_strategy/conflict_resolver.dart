library;

/// Extracted logic that determines whether to replace or skip an overlay based on its strategy

import '../../presentation/overlay_entries/_overlay_entries.dart';
import 'conflicts_strategy.dart';

final class OverlayConflictResolver {
  const OverlayConflictResolver._();

  static bool shouldReplaceCurrent(
    OverlayUIEntry next,
    OverlayUIEntry current,
  ) {
    final n = next.strategy;
    final c = current.strategy;

    return switch (n.policy) {
      OverlayReplacePolicy.forceReplace => true,
      OverlayReplacePolicy.forceIfSameCategory => n.category == c.category,
      OverlayReplacePolicy.forceIfLowerPriority =>
        n.priority.index > c.priority.index,
      OverlayReplacePolicy.waitQueue => false,
    };
  }

  static bool shouldWait(OverlayUIEntry next) =>
      next.strategy.policy == OverlayReplacePolicy.waitQueue;
}
