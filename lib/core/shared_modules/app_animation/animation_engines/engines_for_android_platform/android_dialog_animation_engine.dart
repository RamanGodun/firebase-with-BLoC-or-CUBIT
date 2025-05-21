import 'package:flutter/material.dart';
import '../__animation_engine_interface.dart';

/// 🤖 [AndroidDialogAnimationEngine] — slide + fade + scale animation for dialogs
/// 🎞️ Used for Material-style dialogs (state- or user-driven)
/// ✅ Combines opacity, subtle scale, and upward slide on entry
final class AndroidDialogAnimationEngine implements ISlideAnimationEngine {
  static const _duration = Duration(milliseconds: 400);
  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

  /// Initializes the engine with Android-style animation curves
  /// - Opacity: fade in
  /// - Scale: slight pop
  /// - Slide: vertical from bottom
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

  /// Starts the forward animation from 0
  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  /// ⏪ Reverses the animation and returns a future when complete
  /// Supports [fast] override for instant collapse in conflict flows
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

  /// Opacity animation (fade in/out)
  @override
  Animation<double> get opacity => _opacity;

  /// Scale animation (95% → 100%)
  @override
  Animation<double> get scale => _scale;

  /// Slide animation (from offset (0, 0.12) to center)
  @override
  Animation<Offset> get slide => _slide;

  /// Disposes the internal animation controller
  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
