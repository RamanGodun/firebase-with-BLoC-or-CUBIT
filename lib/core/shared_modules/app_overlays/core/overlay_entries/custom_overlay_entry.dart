part of '_overlay_entries.dart';

/// 🧩 [CustomOverlayEntry] — Flexible overlay entry for custom widgets
/// - Can be used for loaders, spinners, banners, etc.
/// - Accepts any widget and display duration
/// - Encapsulates conflict strategy and dismiss rules
/// - Builds a platform-aware [AppCustomOverlay]
// ----------------------------------------------------------------------

final class CustomOverlayEntry extends OverlayUIEntry {
  final Widget child;
  final bool isError; // ❗ Marks as an error (affects strategy & priority)

  // ⏱️ How long the overlay remains on screen (0 = persistent)
  @override
  final Duration duration;

  // 🔐 Dismiss policy (persistent or dismissible)
  @override
  final OverlayDismissPolicy dismissPolicy;

  const CustomOverlayEntry({
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.isError = false,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  /// ⚙️ Defines how this entry behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.normal,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.forceIfLowerPriority,
    category: isError ? OverlayCategory.error : OverlayCategory.otherCustom,
  );

  /// 🏗️ Builds a wrapped overlay widget with platform context
  /// Called by Dispatcher during insertion
  @override
  Widget build(BuildContext context) =>
      AppCustomOverlay(platform: context.platform, child: child);
}
