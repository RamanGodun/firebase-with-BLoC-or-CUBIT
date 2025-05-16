part of '_overlay_entries.dart';

/// 🍞 [SnackbarOverlayEntry] — Overlay entry for platform-adaptive snackbars
/// - Acts as a configuration object for [OverlayDispatcher]
/// - Encapsulates conflict strategy and dismiss behavior
/// - Builds a ready-to-render [AppSnackbarWidget] widget
// ----------------------------------------------------------------------

final class SnackbarOverlayEntry extends OverlayUIEntry {
  final String message;
  final OverlayUIPresets? preset; // 🎨 Optional style preset
  final bool isError; // ❗ Marks as an error (affects strategy and priority)
  final IconData? icon;

  // 🔐 Dismiss policy (persistent or dismissible)
  @override
  final OverlayDismissPolicy dismissPolicy;

  const SnackbarOverlayEntry(
    this.message, {
    this.preset = const OverlayInfoUIPreset(),
    this.isError = false,
    this.icon,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  /// ⏱️ Determines how long the snackbar remains on screen
  @override
  Duration get duration =>
      preset?.resolve().duration ?? const Duration(seconds: 2);

  /// 🫥 Enables tap passthrough to UI underneath (non-blocking UX)
  @override
  bool get tapPassthroughEnabled => true;

  /// ⚙️ Defines how this entry behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.high,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.forceIfLowerPriority,
    category: isError ? OverlayCategory.error : OverlayCategory.snackbar,
  );

  /// 🏗️ Builds animated platform-aware snackbar
  @override
  Widget build(BuildContext context) {
    final resolvedProps =
        preset?.resolve() ?? const OverlayInfoUIPreset().resolve();
    final animationPlatform = context.platform.toAnimationPlatform();

    return AnimationHost(
      overlayType: UserDrivenOverlayType.snackbar,
      displayDuration: duration,
      platform: animationPlatform,
      onDismiss: onDismiss,
      builderWithEngine:
          (engine) => switch (animationPlatform) {
            AnimationPlatform.ios ||
            AnimationPlatform.adaptive => IOSSnackbarCard(
              message: message,
              icon: icon ?? resolvedProps.icon,
              engine: engine,
              props: resolvedProps,
            ),
            AnimationPlatform.android => AndroidSnackbarCard(
              message: message,
              icon: icon ?? resolvedProps.icon,
              engine: engine as ISlideAnimationEngine,
              props: resolvedProps,
            ),
          },
    );
  }

  ////
}
