import 'package:flutter/material.dart';
import '../__animation_engine_interface.dart';

/// 🎯 [AndroidBannerAnimationEngine] — fade + slide animation
/// 🎞️ Designed for Material-style overlays (e.g. banners, snackbars)
/// ✅ Uses opacity + slide transition for subtle Android-feel
final class AndroidBannerAnimationEngine implements ISlideAnimationEngine {
  static const _defaultDuration = Duration(milliseconds: 450);
  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide; // ↕️ Vertical entrance slide

  /// Initializes controller and animations
  @override
  void initialize(TickerProvider vsync) {
    dispose();
    _controller = AnimationController(vsync: vsync, duration: _defaultDuration);

    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));

    _scale = Tween(
      begin: 0.98,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.decelerate));

    _slide = Tween(
      begin: const Offset(0, -0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));
  }

  /// Plays entrance animation from start
  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  /// Reverses animation for exit
  @override
  Future<void> reverse() async => _controller?.reverse();

  /// Opacity animation (fade in/out)
  @override
  Animation<double> get opacity => _opacity;

  /// Scale animation (zoom effect)
  @override
  Animation<double> get scale => _scale;

  /// Slide animation (vertical entrance)
  @override
  Animation<Offset> get slide => _slide;

  /// Disposes the animation controller
  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
