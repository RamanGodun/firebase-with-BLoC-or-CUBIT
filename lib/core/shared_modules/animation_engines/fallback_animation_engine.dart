// === Fallback Engine (safe no-op engine) ===
import 'package:flutter/material.dart';

import '__animation_engine_interface.dart';

final class FallbackAnimationEngine implements IAnimationEngine {
  @override
  void dispose() {}

  @override
  void initialize(TickerProvider vsync) {}

  @override
  Animation<double> get opacity => kAlwaysCompleteAnimation;

  @override
  Animation<double> get scale => kAlwaysCompleteAnimation;

  @override
  void play({Duration? durationOverride}) {}

  @override
  Future<void> reverse() async {}
}

const AlwaysStoppedAnimation<double> kAlwaysCompleteAnimation =
    AlwaysStoppedAnimation(1.0);
