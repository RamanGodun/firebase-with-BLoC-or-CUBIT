part of '_overlay_entries.dart';

/// ⏳ [LoaderOverlayEntry] — Overlay entry for platform-adaptive loaders
/// - Used for short-lived loading indicators or blocking states
/// - Auto-dismisses after [duration] unless set otherwise
/// - Provides conflict rules and delegates rendering to [AppLoader]
// ----------------------------------------------------------------------

final class LoaderOverlayEntry extends OverlayUIEntry {
  @override
  final Duration duration;

  // 🔐 Whether the loader can be dismissed externally
  @override
  final OverlayDismissPolicy dismissPolicy;

  const LoaderOverlayEntry({
    this.duration = const Duration(seconds: 2),
    this.dismissPolicy = OverlayDismissPolicy.persistent,
  });

  /// ⚙️ Defines how this loader behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.high,
    policy: OverlayReplacePolicy.forceIfLowerPriority,
    category: OverlayCategory.loader,
  );

  /// 🏗️ Builds a platform-specific loader widget
  /// Called by Dispatcher during insertion
  @override
  Widget build(BuildContext context) => AppLoader(platform: context.platform);
}
