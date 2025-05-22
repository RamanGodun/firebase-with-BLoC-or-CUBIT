part of '__animation_engine.dart';

/// ✅ \[BaseAnimationEngine] — General base realization  of Engine
/// 🔁 Incapsulates logic of `initialize`, `play`, `reverse`, `dispose`
/// 🔧 Allows  override  tween'and through methods
///----------------------------------------------------------------

abstract class BaseAnimationEngine extends AnimationEngine {
  late final AnimationController controller;

  @override
  void initialize(TickerProvider vsync, {Duration? duration}) {
    dispose();
    controller = AnimationController(
      vsync: vsync,
      duration: duration ?? defaultDuration,
    );
    setupAnimations();
  }

  /// Defines tweens and assigns them to exposed animation fields.
  void setupAnimations();

  @override
  void play({Duration? durationOverride}) {
    if (durationOverride != null) {
      controller.duration = durationOverride;
    }
    controller.forward(from: 0);
  }

  @override
  Future<void> reverse({bool fast = false}) async {
    final d = fast ? fastReverseDuration : controller.duration;
    await controller.animateBack(0.0, duration: d);
  }

  @override
  void dispose() {
    controller.dispose();
  }

  /// Override in subclasses to provide default duration.
  Duration get defaultDuration;

  /// Override for fast reverse (e.g., dismissal).
  Duration get fastReverseDuration => const Duration(milliseconds: 150);
}
