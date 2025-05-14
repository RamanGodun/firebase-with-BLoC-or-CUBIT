part of '_overlay_entries.dart';

/// 🧩 [CustomOverlayEntry] — Generic overlay entry with any widget and duration
/// ✅ Unified entry for dispatcher
/// ✅ Delegates UI to [AppCustomOverlay]
//--------------------------------------------------------------------------------

final class CustomOverlayEntry extends OverlayUIEntry {
  final Widget child;
  final bool isError;
  @override
  final Duration duration;
  @override
  final OverlayDismissPolicy dismissPolicy;

  const CustomOverlayEntry({
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.isError = false,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.normal,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.forceIfLowerPriority,
    category: isError ? OverlayCategory.error : OverlayCategory.otherCustom,
  );

  @override
  Widget build(BuildContext context) =>
      AppCustomOverlay(platform: context.platform, child: child);

  ///
}
