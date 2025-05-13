part of '_overlay_entries.dart';

/// 🍎 [IOSBannerOverlayEntry] — Glass-style banner overlay for iOS/macOS
final class IOSBannerOverlayEntry extends OverlayUIEntry {
  final String message;
  @override
  final OverlayMessageKey? messageKey;
  final OverlayUIPresets? preset;
  final bool isError;
  final IconData? icon;

  const IOSBannerOverlayEntry(
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
    return AnimatedOverlayWidget(message: message, icon: icon ?? props.icon);
  }
}
