part of '_overlay_entries.dart';

/// 🪧 [BannerOverlayEntry] — Represents a banner overlay (animated or custom)
final class BannerOverlayEntry extends OverlayUIEntry {
  final Widget banner;
  @override
  final Duration duration;
  @override
  final OverlayMessageKey? messageKey;

  const BannerOverlayEntry(
    this.banner, {
    this.duration = const Duration(seconds: 2),
    this.messageKey,
  });

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.forceIfSameCategory,
    category: OverlayCategory.bannerTheme,
  );
}



/// 🎨 [ThemedBannerOverlayEntry] — Predefined banner with icon and message, styled by theme
final class ThemedBannerOverlayEntry extends OverlayUIEntry {
  final String message;
  final IconData icon;
  @override
  final OverlayMessageKey? messageKey;

  const ThemedBannerOverlayEntry(this.message, this.icon, {this.messageKey});

  @override
  Duration get duration => const Duration(seconds: 2);

  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.forceIfSameCategory,
    category: OverlayCategory.bannerTheme,
  );
}
