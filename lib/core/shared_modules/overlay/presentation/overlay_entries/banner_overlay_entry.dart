part of '_overlay_entries.dart';

/// 🪧 [BannerOverlayEntry] — Unified platform-aware banner overlay entry
final class BannerOverlayEntry extends OverlayUIEntry {
  final String message;
  @override
  final OverlayMessageKey? messageKey;
  final OverlayUIPresets? preset;
  final bool isError;
  final IconData? icon;

  const BannerOverlayEntry(
    this.message,
    this.messageKey, {
    this.preset,
    this.isError = false,
    this.icon,
  });

  @override
  Duration get duration =>
      preset?.resolve().duration ?? const Duration(seconds: 2);

  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.normal,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.forceIfSameCategory,
    category:
        isError ? OverlayCategory.bannerError : OverlayCategory.bannerTheme,
  );

  @override
  Widget build(BuildContext context) {
    final props = preset?.resolve() ?? const OverlayInfoUIPreset().resolve();
    return AppBanner(
      message: message,
      icon: icon ?? props.icon,
      props: props,
      platform: context.platform,
    );
  }

  ///
  @override
  OverlayDismissPolicy get dismissPolicy => OverlayDismissPolicy.dismissible;

  ///
}
