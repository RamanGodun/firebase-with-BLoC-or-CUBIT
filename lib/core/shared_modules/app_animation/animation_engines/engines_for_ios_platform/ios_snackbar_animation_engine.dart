import 'package:flutter/material.dart';
import '../__animation_engine_interface.dart';

/// 🍎 [IOSSnackbarAnimationEngine] — iOS/macOS-style snackbar animation engine
/// - Provides glass-like fade + scale effect for snackbars
/// - Designed for use with [AnimationHost] on iOS/macOS overlays
/// - Implements [IAnimationEngine] for platform-specific behavior
//--------------------------------------------------------------

final class IOSSnackbarAnimationEngine implements IAnimationEngine {
  static const _defaultDuration = Duration(milliseconds: 600);
  AnimationController? _controller;

  /// Controls opacity transition (fade in/out)
  late final Animation<double> _opacity;

  /// Controls scale transition (slight pop effect)
  late final Animation<double> _scale;

  /// Initializes animation controller and transitions
  /// Must be called inside `initState` with valid [TickerProvider]
  @override
  void initialize(TickerProvider vsync) {
    dispose();
    _controller = AnimationController(vsync: vsync, duration: _defaultDuration);

    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller!);

    _scale = Tween(
      begin: 0.95,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.decelerate)).animate(_controller!);
  }

  /// Plays the animation forward from the beginning
  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  /// ⏪ Reverses the animation (used for dismissal)
  /// Supports [fast] override for abrupt collapse
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

  /// Provides the current opacity animation
  @override
  Animation<double> get opacity => _opacity;

  /// Provides the current scale animation
  @override
  Animation<double> get scale => _scale;

  /// Disposes the controller and releases resources
  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
