import 'package:flutter/material.dart';

/// ✅ Updated TapThroughOverlayBarrier with precise pointer passthrough logic
/// ✅ Now guarantees that taps reach widgets _under_ the overlay if enabled
class TapThroughOverlayBarrier extends StatelessWidget {
  final Widget child;
  final bool enablePassthrough;
  final VoidCallback? onTapOverlay;

  const TapThroughOverlayBarrier({
    super.key,
    required this.child,
    this.enablePassthrough = false,
    this.onTapOverlay,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ Transparent stack layer that lets taps fall through if enabled
    return Stack(
      children: [
        Positioned.fill(
          child: Listener(
            behavior: HitTestBehavior.translucent,
            onPointerDown: (event) {
              if (enablePassthrough) {
                // ✅ Immediately dismiss overlay
                onTapOverlay?.call();
              }
            },
            child: const SizedBox.expand(),
          ),
        ),

        // ⚠️ Overlay widget rendered above but not blocking interaction if passthrough enabled
        IgnorePointer(ignoring: enablePassthrough, child: child),
      ],
    );
  }
}
