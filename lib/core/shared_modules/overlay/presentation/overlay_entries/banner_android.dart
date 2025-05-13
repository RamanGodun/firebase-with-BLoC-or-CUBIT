part of '_overlay_entries.dart';

/// 🎨 [AndroidBannerOverlayEntry] — Material-style banner overlay for Android
final class AndroidBannerOverlayEntry extends OverlayUIEntry {
  final String message;
  @override
  final OverlayMessageKey? messageKey;
  final OverlayUIPresets? preset;
  final bool isError;
  final IconData? icon;

  const AndroidBannerOverlayEntry(
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
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        color: props.color.withOpacity(0.9),
        child: Padding(
          padding: props.contentPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon ?? props.icon, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: TextWidget(
                  message,
                  TextType.bodyMedium,
                  color: context.colorScheme.primary,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
