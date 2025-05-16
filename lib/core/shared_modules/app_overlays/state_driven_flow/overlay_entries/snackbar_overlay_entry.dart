part of '_overlay_entries.dart';

/// 🍞 [SnackbarOverlayEntry] — State-driven platform-aware snackbar
/// - Used by [OverlayDispatcher] for automatic snackbar rendering
/// - Encapsulates priority, dismiss policy, and visual props
/// - Built via [AnimationHost] and animated per platform
/// - Called by Dispatcher during overlay insertion
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

  /// 🧱 Builds and animates the snackbar via [AnimationHost]
  @override
  Widget build(BuildContext context) {
    //
    /// Internally resolves props
    final resolvedProps =
        preset?.resolve() ?? const OverlayInfoUIPreset().resolve();

    // Selects [AnimationPlatform] (iOS/Android)
    final animationPlatform = context.platform.toAnimationPlatform();

    /// [AnimationHost] invokes [engine.play] and auto-dismiss logic
    return AnimationHost(
      overlayType: UserDrivenOverlayType.snackbar,
      displayDuration: duration,
      platform: animationPlatform,
      onDismiss: onDismiss,
      // 🎯 Builds the snackbar widget with platform-specific animation engine
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

  //
}
