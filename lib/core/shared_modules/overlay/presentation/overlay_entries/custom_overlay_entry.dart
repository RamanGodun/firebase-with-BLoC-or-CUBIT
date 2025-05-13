part of '_overlay_entries.dart';

/// 🧩 [CustomOverlayEntry] — Generic overlay entry with any widget and duration
//--------------------------------------------------------------------------------

final class CustomOverlayEntry extends OverlayUIEntry {
  //
  final Widget widget;
  @override
  final Duration duration;

  const CustomOverlayEntry(
    this.widget, {
    this.duration = const Duration(seconds: 2),
  });

  /// 🧠 Conflict strategy:
  /// — Waits in queue by default
  /// — Neutral priority, used for flexible non-critical UI feedback
  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.bannerTheme,
  );

  ///
}
