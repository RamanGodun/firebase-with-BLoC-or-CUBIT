part of '_animation_engine.dart';

final class FallbackAnimationEngine extends AnimationEngine {
  @override
  void initialize(TickerProvider vsync) {}

  @override
  void play({Duration? durationOverride}) {}

  @override
  Future<void> reverse({bool fast = false}) async {}

  @override
  void dispose() {}

  @override
  Animation<double> get opacity => kAlwaysCompleteAnimation;

  @override
  Animation<double> get scale => kAlwaysCompleteAnimation;
}
