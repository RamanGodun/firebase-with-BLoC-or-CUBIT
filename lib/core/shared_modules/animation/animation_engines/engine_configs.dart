import 'package:flutter/material.dart' show Curve, Offset;

/// 🌟 [AndroidOverlayAnimationConfig] — defines animation presets for Android overlays
/// ✅ Used internally by [AndroidOverlayAnimationEngine] to unify animation logic
///----------------------------------------------------------------

final class AndroidOverlayAnimationConfig {
  final Duration duration;
  final Duration fastDuration;
  final Curve opacityCurve;
  final Curve scaleCurve;
  final double scaleBegin;
  final Curve? slideCurve;
  final Offset? slideOffset;

  const AndroidOverlayAnimationConfig({
    required this.duration,
    required this.fastDuration,
    required this.opacityCurve,
    required this.scaleCurve,
    required this.scaleBegin,
    this.slideCurve,
    this.slideOffset,
  });
}

///
///
//

/// 🎛️ Configuration class for iOS overlay animations
/// Defines durations, curves, and scale parameters for each overlay type
///----------------------------------------------------------------
final class IOSOverlayAnimationConfig {
  final Duration duration;
  final Duration fastDuration;
  final Curve opacityCurve;
  final Curve scaleCurve;
  final double scaleBegin;

  const IOSOverlayAnimationConfig({
    required this.duration,
    required this.fastDuration,
    required this.opacityCurve,
    required this.scaleCurve,
    required this.scaleBegin,
  });
}
