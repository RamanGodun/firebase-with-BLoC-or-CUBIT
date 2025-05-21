part of '_animation_engine.dart';

/// 🤖 [AndroidBannerAnimationEngine] — fade + slide + scale for Material banners
/// ✅ Subtle Android entrance for top banners/snackbars
final class AndroidBannerAnimationEngine extends AnimationEngine {
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
      begin: 0.98,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.decelerate));

    _slide = Tween(
      begin: const Offset(0, -0.06),
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
        duration: const Duration(milliseconds: 150),
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

/// 🍎 [IOSBannerAnimationEngine] — fade + scale animation for iOS banners
/// ✅ Mimics system iOS banner motion (top-entry, floaty)
final class IOSBannerAnimationEngine extends AnimationEngine {
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
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller!);

    _scale = Tween(
      begin: 0.92,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOutBack)).animate(_controller!);
  }

  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  @override
  Future<void> reverse({bool fast = false}) async {
    if (fast) {
      await _controller?.animateBack(
        0.0,
        duration: const Duration(milliseconds: 160),
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
