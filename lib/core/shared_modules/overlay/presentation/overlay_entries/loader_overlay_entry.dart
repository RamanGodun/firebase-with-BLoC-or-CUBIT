part of '_overlay_entries.dart';

/// ⏳ [LoaderOverlayEntry] — Unified platform-aware loading spinner
/// ✅ Used in queue
/// ✅ Contains strategy and lightweight build() logic only
/// ✅ Delegates full UI to [AppLoader]
//--------------------------------------------------------------------------------

final class LoaderOverlayEntry extends OverlayUIEntry {
  @override
  final Duration duration;
  @override
  final OverlayDismissPolicy dismissPolicy;

  const LoaderOverlayEntry({
    this.duration = const Duration(seconds: 2),
    this.dismissPolicy = OverlayDismissPolicy.persistent,
  });

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.low,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.loader,
  );

  @override
  OverlayMessageKey? get messageKey => null;

  @override
  Widget build(BuildContext context) => AppLoader(platform: context.platform);
}
