import 'package:flutter/material.dart';

import '../animation_engines/__animation_engine.dart';

/// 🎞️ [AnimatedOverlayShell] — Universal animation shell for overlays
/// - Wraps child with Slide (optional) + Fade + Scale transitions
/// - Used in: banners, dialogs, snackbars (Android/iOS)
/// - Accepts [AnimationEngine] with configured transitions
/// ───────────────────────────────────────────────────────────────
final class AnimatedOverlayShell extends StatelessWidget {
  final AnimationEngine engine;
  final Widget child;

  const AnimatedOverlayShell({
    super.key,
    required this.engine,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget animated = FadeTransition(
      opacity: engine.opacity,
      child: ScaleTransition(scale: engine.scale, child: child),
    );

    // Wrap with SlideTransition anyway — fallback to static offset
    animated = SlideTransition(
      position: engine.slide ?? const AlwaysStoppedAnimation(Offset.zero),
      child: animated,
    );

    return animated;
  }
}
