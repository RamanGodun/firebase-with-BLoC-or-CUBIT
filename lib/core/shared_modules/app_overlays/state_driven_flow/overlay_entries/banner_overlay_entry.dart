part of '_overlay_entries.dart';

/// 🪧 [BannerOverlayEntry] — Overlay entry for platform-adaptive banners
/// - Acts as a configuration object for [OverlayDispatcher]
/// - Encapsulates conflict strategy and dismiss rules
/// - Builds a ready-to-render [AppBanner] widget
// ----------------------------------------------------------------------

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

  /// 🏗️ Builds a platform-aware banner widget with resolved props
  /// Called by Dispatcher during overlay insertion
  @override
  Widget build(BuildContext context) {
    final resolvedProps =
        preset?.resolve() ?? const OverlayInfoUIPreset().resolve();
    final animationPlatform = context.platform.toAnimationPlatform();

    return AnimationHost(
      overlayType: UserDrivenOverlayType.banner,
      displayDuration: duration,
      platform: animationPlatform,
      onDismiss: onDismiss,
      builderWithEngine:
          (engine) => switch (animationPlatform) {
            AnimationPlatform.ios ||
            AnimationPlatform.adaptive => IOSBannerCard(
              message: message,
              icon: icon ?? resolvedProps.icon,
              engine: engine,
              props: resolvedProps,
            ),
            AnimationPlatform.android => AndroidBannerCard(
              message: message,
              icon: icon ?? resolvedProps.icon,
              engine: engine as ISlideAnimationEngine,
              props: resolvedProps,
            ),
          },
    );
  }

  ///
}
