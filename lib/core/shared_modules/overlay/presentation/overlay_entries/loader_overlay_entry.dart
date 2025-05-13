part of '_overlay_entries.dart';

/// ⏳ [LoaderOverlayEntry] - Lightweight non-intrusive loading overlay entry
//--------------------------------------------------------------------------------

final class LoaderOverlayEntry extends OverlayUIEntry {
  //
  final Widget loader;
  @override
  final Duration duration;

  const LoaderOverlayEntry(
    this.loader, {
    this.duration = const Duration(seconds: 2),
  });

  /// 🧠 Conflict strategy:
  /// — Waits in queue and never forces dismissal of existing overlay
  /// — Used for silent background feedback
  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.low,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.loader,
  );

  ///
}
