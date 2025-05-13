part of '_overlay_entries.dart';

/// 🧩 [CustomOverlayEntry] — Generic overlay entry with any widget and duration
//--------------------------------------------------------------------------------

final class IOSCustomOverlayEntry extends OverlayUIEntry {
  final Widget child;
  @override
  final Duration duration;

  const IOSCustomOverlayEntry(
    this.child, {
    this.duration = const Duration(seconds: 2),
  });

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.bannerTheme,
  );

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: child,
    ),
  );
}

///

final class AndroidCustomOverlayEntry extends OverlayUIEntry {
  final Widget child;
  @override
  final Duration duration;

  const AndroidCustomOverlayEntry(
    this.child, {
    this.duration = const Duration(seconds: 2),
  });

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.bannerTheme,
  );

  @override
  Widget build(BuildContext context) => Center(
    child: Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(8),
      child: Padding(padding: const EdgeInsets.all(12), child: child),
    ),
  );
}
