part of '__animation_engine.dart';

final class FallbackAnimationEngine extends AnimationEngine {
  /// Indicates whether the fallback engine was used (for logging/debugging).
  // ignore: unused_field
  bool _isActive = false;

  @override
  void initialize(TickerProvider vsync) {
    _isActive = true;
  }

  @override
  void play({Duration? durationOverride}) {
    // No-op
  }

  @override
  Future<void> reverse({bool fast = false}) async {
    // No-op
  }

  @override
  void dispose() {
    _isActive = false;
  }

  @override
  Animation<double> get opacity => kAlwaysCompleteAnimation;

  @override
  Animation<double> get scale => kAlwaysCompleteAnimation;

  @override
  Animation<Offset>? get slide => null;
}
