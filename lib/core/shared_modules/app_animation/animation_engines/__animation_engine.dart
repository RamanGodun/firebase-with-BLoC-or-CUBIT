import 'package:flutter/material.dart'
    show
        Animation,
        AnimationController,
        CurveTween,
        Curves,
        TickerProvider,
        Tween;
import '__animation_engine_interface.dart';

/// 🌀 [AnimationEngine] — Default fade & scale animation engine
/// - Provides elastic scale and ease-out fade transitions
/// - Used for iOS/macOS overlays and non-sliding components
/// - Controlled via [AnimationController]
//-------------------------------------------------------

final class AnimationEngine implements IAnimationEngine {
  static const _defaultDuration = Duration(milliseconds: 600);

  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  /// Initializes [AnimationController] and defines animation curves
  @override
  void initialize(TickerProvider vsync) {
    dispose();
    _controller = AnimationController(vsync: vsync, duration: _defaultDuration);
    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller!);
    _scale = Tween(
      begin: 0.8,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.elasticOut)).animate(_controller!);
  }

  /// Starts forward animation (fade in & scale up)
  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  /// Plays reverse animation (fade out & scale down)
  @override
  Future<void> reverse() async => _controller?.reverse();

  /// Provides opacity animation (0 → 1)
  @override
  Animation<double> get opacity => _opacity;

  /// Provides scale animation (0.8 → 1.0)
  @override
  Animation<double> get scale => _scale;

  /// Disposes internal controller and cleans up resources
  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }

  //
}
