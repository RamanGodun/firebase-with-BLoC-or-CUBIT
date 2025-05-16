import 'package:flutter/material.dart';

/// 🌀 [IAnimationEngine] — Core interface for overlay animations
/// - Defines common API for playing and reversing entry transitions
/// - Provides animated [opacity] and [scale] for visual effects
/// - Used by [AnimationHost] to control platform-specific animations
//------------------------------------------------------------------

abstract interface class IAnimationEngine {
  /// Initializes engine with [TickerProvider] (usually from `State`)
  void initialize(TickerProvider vsync);
  // Plays the forward animation (fade/scale in)
  void play({Duration? durationOverride});
  // Reverses the animation (fade/scale out)
  Future<void> reverse();
  // Disposes animation controllers
  void dispose();
  // 🔁 Opacity animation (0 → 1)
  Animation<double> get opacity;
  // 🔁 Scale animation (0.9 → 1)
  Animation<double> get scale;
}

/// ➕ [ISlideAnimationEngine] — Extends [IAnimationEngine] with slide animation
/// - Adds [slide] for vertical entry (used in banners/snackbars)
//------------------------------------------------------------------

abstract interface class ISlideAnimationEngine implements IAnimationEngine {
  /// 🔁 Slide animation (e.g. Offset(0, -1) → Offset.zero)
  Animation<Offset> get slide;
}
