import '../core/overlay_enums.dart';

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
