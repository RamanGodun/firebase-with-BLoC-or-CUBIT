import '../../presentation/overlay_entries/_overlay_entries.dart';
import 'conflicts_strategy.dart';

/// 🎯 Logic to determine overlay conflict resolution strategy
final class OverlayConflictResolver {
  const OverlayConflictResolver._();

  /// 🤝 Should [next] replace the [current] active overlay?
  static bool shouldReplaceCurrent(
    OverlayUIEntry next,
    OverlayUIEntry current,
  ) {
    final n = next.strategy;
    final c = current.strategy;

    return switch (n.policy) {
      //
      OverlayReplacePolicy.forceReplace => true,

      //
      OverlayReplacePolicy.forceIfSameCategory => n.category == c.category,

      //
      OverlayReplacePolicy.forceIfLowerPriority =>
        n.priority.index > c.priority.index,

      //
      OverlayReplacePolicy.dropIfSameType =>
        next.runtimeType == current.runtimeType,

      //
      OverlayReplacePolicy.waitQueue => false,
    };
  }

  /// ⏳ Whether to wait or silently ignore the request
  static bool shouldWait(OverlayUIEntry entry) =>
      entry.strategy.policy == OverlayReplacePolicy.waitQueue;
}
