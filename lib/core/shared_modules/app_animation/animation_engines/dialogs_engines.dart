part of '_animation_engine.dart';

/// 🍎 [IOSDialogAnimationEngine] — fade + scale animation for iOS dialogs
/// ✅ Matches Cupertino dialog transition behavior
final class IOSDialogAnimationEngine extends AnimationEngine {
  static const _duration = Duration(milliseconds: 500);

  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  @override
  void initialize(TickerProvider vsync) {
    dispose();
    _controller = AnimationController(vsync: vsync, duration: _duration);

    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller!);

    _scale = Tween(
      begin: 0.9,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.decelerate)).animate(_controller!);
  }

  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  @override
  Future<void> reverse({bool fast = false}) async {
    if (fast) {
      await _controller?.animateBack(
        0.0,
        duration: const Duration(milliseconds: 180),
      );
    } else {
      await _controller?.reverse();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }

  @override
  Animation<double> get opacity => _opacity;

  @override
  Animation<double> get scale => _scale;
}

/// 🤖 [AndroidDialogAnimationEngine] — slide + fade + scale animation for Material dialogs
/// ✅ Matches Android Material motion for alert dialogs
final class AndroidDialogAnimationEngine extends AnimationEngine {
  static const _duration = Duration(milliseconds: 400);

  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  @override
  void initialize(TickerProvider vsync) {
    dispose();
    _controller = AnimationController(vsync: vsync, duration: _duration);

    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _scale = Tween(
      begin: 0.95,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _slide = Tween(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));
  }

  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  @override
  Future<void> reverse({bool fast = false}) async {
    if (fast) {
      await _controller?.animateBack(
        0.0,
        duration: const Duration(milliseconds: 180),
      );
    } else {
      await _controller?.reverse();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }

  @override
  Animation<double> get opacity => _opacity;

  @override
  Animation<double> get scale => _scale;

  @override
  Animation<Offset>? get slide => _slide;
}
