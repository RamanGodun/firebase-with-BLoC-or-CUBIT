part of '_overlay_entries.dart';

/// 🧩 [CustomOverlayEntry] — Generic overlay entry with any widget and duration
/// ✅ Unified entry for dispatcher
/// ✅ Delegates UI to [AppCustomOverlay]
//--------------------------------------------------------------------------------

final class CustomOverlayEntry extends OverlayUIEntry {
  final Widget child;
  @override
  final Duration duration;

  const CustomOverlayEntry({
    required this.child,
    this.duration = const Duration(seconds: 2),
  });

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.bannerTheme,
  );

  @override
  Widget build(BuildContext context) =>
      AppCustomOverlay(platform: context.platform, child: child);
}
