import 'package:flutter/material.dart';

import '../__animation_engine_interface.dart';

/// 🍞 [AndroidSnackbarAnimationEngine] — fade + slide animation engine for snackbars
/// - Optimized for Material-style overlays on Android
/// - Combines opacity, scale, and upward slide transitions
final class AndroidSnackbarAnimationEngine implements ISlideAnimationEngine {
  static const _defaultDuration = Duration(milliseconds: 450);
  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  /// Initializes animations for opacity, scale, and slide
  /// - Called once with a [TickerProvider] for vsync binding
  @override
  void initialize(TickerProvider vsync) {
    dispose();
    _controller = AnimationController(vsync: vsync, duration: _defaultDuration);

    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));

    _scale = Tween(
      begin: 0.96,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));

    _slide = Tween(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeOut));
  }

  /// Plays the entrance animation from the beginning
  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  /// Reverses the animation for smooth exit transition
  @override
  Future<void> reverse() async => _controller?.reverse();

  /// Current opacity animation
  @override
  Animation<double> get opacity => _opacity;

  /// Current scale animation
  @override
  Animation<double> get scale => _scale;

  /// Current slide animation (Y-axis offset)
  @override
  Animation<Offset> get slide => _slide;

  /// Cleans up the controller and frees resources
  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
