import 'package:flutter/material.dart';

/// ✅ TapThroughOverlayBarrier v2
/// ✅ Handles passthrough and dismiss logic in one place
/// ✅ Guarantees solid UX for theme toggle / fast interactions
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
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) {
        if (enablePassthrough) {
          onTapOverlay?.call(); // 🔁 dismiss overlay if needed
        }
      },
      child: Stack(
        children: [
          // ⚠️ Renders overlay content but allows passthrough when needed
          IgnorePointer(
            ignoring: enablePassthrough,
            child: child,
          ),
        ],
      ),
    );
  }
}
