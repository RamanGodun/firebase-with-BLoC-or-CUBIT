part of '_overlay_entries.dart';

/// ⏳ [IOSLoaderOverlayEntry] — iOS-style loading spinner
//--------------------------------------------------------------------------------

final class IOSLoaderOverlayEntry extends OverlayUIEntry {
  @override
  final Duration duration;
  const IOSLoaderOverlayEntry({this.duration = const Duration(seconds: 2)});

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.low,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.loader,
  );

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(child: CircularProgressIndicator.adaptive()),
    ),
  );

  @override
  OverlayMessageKey? get messageKey => null;
}

/// ⏳ [AndroidLoaderOverlayEntry] — Material-style loading spinner
//--------------------------------------------------------------------------------

final class AndroidLoaderOverlayEntry extends OverlayUIEntry {
  @override
  final Duration duration;
  const AndroidLoaderOverlayEntry({this.duration = const Duration(seconds: 2)});

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.low,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.loader,
  );

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.85),
        shape: BoxShape.circle,
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: const CircularProgressIndicator(),
    ),
  );

  @override
  OverlayMessageKey? get messageKey => null;
}
