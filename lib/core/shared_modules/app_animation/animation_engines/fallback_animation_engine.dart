import 'package:flutter/material.dart';
import '__animation_engine_interface.dart';

/// 🧩 [FallbackAnimationEngine] — no-op animation engine
/// - Used as a default fallback when no platform-specific engine is matched
/// - Provides completed animations with no side effects
/// - Useful in testing or unsupported overlay scenarios
//------------------------------------------------------

final class FallbackAnimationEngine implements IAnimationEngine {
  /// 🚫 No-op dispose (nothing to clean up)
  @override
  void dispose() {}

  /// 🚫 No-op initializer (does not create any controller)
  @override
  void initialize(TickerProvider vsync) {}

  /// ✅ Always fully visible
  @override
  Animation<double> get opacity => kAlwaysCompleteAnimation;

  /// ✅ Always fully visible
  @override
  Animation<double> get scale => kAlwaysCompleteAnimation;

  /// 🚫 No animation play (remains static)
  @override
  void play({Duration? durationOverride}) {}

  /// 🚫 No reverse animation (immediate future completion)
  /// Ignores [fast] as it's a no-op engine
  @override
  Future<void> reverse({bool fast = false}) async {}

  //
}
