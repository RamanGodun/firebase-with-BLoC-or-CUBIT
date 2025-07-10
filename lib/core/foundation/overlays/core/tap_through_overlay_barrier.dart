import 'package:flutter/material.dart';

/// 🧱 [TapThroughOverlayBarrier] — Wrapper for overlay content that supports:
/// - 🫥 Tap-through passthrough (e.g. for banners, loaders)
/// - ❌ Dismiss trigger via [onTapOverlay] callback
/// - ✅ Guarantees proper UX for overlays that allow interaction below

final class TapThroughOverlayBarrier extends StatelessWidget {
  ///-------------------------------------------------------

  /// 🧩 The widget to display inside the overlay
  final Widget child;
  // 🫥 If `true`, allows taps to pass through the overlay
  final bool enablePassthrough;
  // ❌ Called when the overlay is tapped (used for dismissing overlays)
  final VoidCallback? onTapOverlay;

  const TapThroughOverlayBarrier({
    super.key,
    required this.child,
    this.enablePassthrough = false,
    this.onTapOverlay,
  });
  //

  @override
  Widget build(BuildContext context) {
    //
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        if (enablePassthrough) {
          onTapOverlay?.call(); // ❌ Trigger dismissal if allowed
        }
      },
      child: Stack(
        children: [
          // 👆 Only blocks interaction if passthrough is disabled
          IgnorePointer(ignoring: enablePassthrough, child: child),
        ],
      ),
    );
  }
}
