import 'package:flutter/material.dart';
import '../__animation_engine_interface.dart';

/// 🍎 [IOSDialogAnimationEngine] — Animation engine for iOS-style dialogs
/// - Provides fade + scale animation
/// - Designed for platform-consistent dialog transitions
/// 🌀 Concrete implementation of [IAnimationEngine] for dialog transitions
//-----------------------------------------------------------------------

final class IOSDialogAnimationEngine implements IAnimationEngine {
  static const _duration = Duration(milliseconds: 500);
  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  @override
  /// 🟢 Initializes controller and tweens for fade + scale animation
  /// Must be called in initState with valid [vsync]
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
  /// ▶️ Triggers forward animation from start
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  /// ⏪ Reverses animation (used before dismiss)
  /// Supports [fast] override for quick collapse transition
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
  /// 🎛️ Opacity animation (for FadeTransition)
  Animation<double> get opacity => _opacity;

  @override
  /// 🎛️ Scale animation (for ScaleTransition)
  Animation<double> get scale => _scale;

  @override
  /// 🛑 Disposes animation controller safely
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
