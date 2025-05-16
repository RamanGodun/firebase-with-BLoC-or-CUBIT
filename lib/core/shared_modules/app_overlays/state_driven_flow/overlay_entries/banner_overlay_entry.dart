part of '_overlay_entries.dart';

/// 🪧 [BannerOverlayEntry] — State-driven platform-aware banner
/// - Used by [OverlayDispatcher] for automatic banner rendering
/// - Defines conflict strategy, priority, and dismissibility
/// - Renders animated [AppBanner] via [AnimationHost]
/// - Called by Dispatcher during overlay insertion
// --------------------------------------------------------------

final class BannerOverlayEntry extends OverlayUIEntry {
  final String message;
  final OverlayUIPresets? preset; // 🎨 Optional style preset
  final bool isError; // ❗ Marks as an error (affects priority & category)
  final IconData? icon;

  // 🔐 Dismiss policy (persistent or dismissible)
  @override
  final OverlayDismissPolicy dismissPolicy;

  const BannerOverlayEntry(
    this.message, {
    this.preset,
    this.isError = false,
    this.icon,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  /// ⏱️ Determines how long the banner remains on screen
  @override
  Duration get duration =>
      preset?.resolve().duration ?? const Duration(seconds: 2);

  /// 🫥 Enables tap passthrough to UI underneath (non-blocking UX)
  @override
  bool get tapPassthroughEnabled => true;

  /// ⚙️ Defines how this entry behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.normal,
    policy: OverlayReplacePolicy.forceIfSameCategory,
    category: isError ? OverlayCategory.error : OverlayCategory.banner,
  );

  /// 🧱 Builds and animates the banner via [AnimationHost]
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
      overlayType: UserDrivenOverlayType.banner,
      displayDuration: duration,
      platform: animationPlatform,
      onDismiss: onDismiss,

      /// 🎯 Builds the banner widget with platform-specific animation engine
      builderWithEngine:
          (engine) => switch (animationPlatform) {
            AnimationPlatform.ios || AnimationPlatform.adaptive => IOSBanner(
              message: message,
              icon: icon ?? resolvedProps.icon,
              engine: engine,
              props: resolvedProps,
            ),
            AnimationPlatform.android => AndroidBanner(
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
