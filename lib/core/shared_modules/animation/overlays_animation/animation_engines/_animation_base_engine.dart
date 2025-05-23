part of '__animation_engine.dart';

/// ✅ \[BaseAnimationEngine] — General base realization  of Engine
/// 🔁 Incapsulates logic of `initialize`, `play`, `reverse`, `dispose`
/// 🔧 Allows  override  tween'and through methods
///----------------------------------------------------------------

abstract class BaseAnimationEngine extends AnimationEngine {
  AnimationController? _controller;
  bool _isInitialized = false;

  /// 🔐 Safe getter for controller — throws if accessed before init.
  AnimationController get controller {
    assert(
      _controller != null,
      '❗ BaseAnimationEngine: controller accessed before initialize() was called',
    );
    return _controller!;
  }

  @override
  void initialize(TickerProvider vsync, {Duration? duration}) {
    if (_isInitialized) return;

    _controller = AnimationController(
      vsync: vsync,
      duration: duration ?? defaultDuration,
    );
    setupAnimations();
    _isInitialized = true;
  }

  /// 🔧 Hook for defining tweens, called after controller created.
  void setupAnimations();

  @override
  void play({Duration? durationOverride}) {
    if (!_isInitialized || _controller == null) return;
    if (durationOverride != null) controller.duration = durationOverride;
    controller.forward(from: 0);
  }

  @override
  Future<void> reverse({bool fast = false}) async {
    if (!_isInitialized) return;

    final d = fast ? fastReverseDuration : controller.duration;
    await controller.animateBack(0.0, duration: d);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    _isInitialized = false;
  }

  /// ⏱️ Default duration for animations
  Duration get defaultDuration;

  /// ⏩ Duration for fast reverse
  Duration get fastReverseDuration => const Duration(milliseconds: 150);
}
