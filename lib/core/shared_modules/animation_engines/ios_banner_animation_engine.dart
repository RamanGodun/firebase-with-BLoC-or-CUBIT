import 'package:flutter/material.dart';
import '__animation_engine_interface.dart';

/// 🧩 [BannerAnimationService] — centralized fade + scale animation logic
/// 🌀 Designed to replicate AnimatedBanner behavior cleanly and safely
/// ✅ Supports DI and multiple lifecycle scenarios (overlay, widget tree)
///----------------------------------------------------------------------------

/// 🌀 Concrete implementation of [IAnimationEngine]
final class IOSAnimationBannerEngine implements IAnimationEngine {
  ///
  static const _defaultDuration = Duration(milliseconds: 600);
  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  /// 🟢 Initializes the animation controller and tweens
  /// Must be called from `initState` with valid vsync
  @override
  void initialize(TickerProvider vsync) {
    dispose();
    _controller = AnimationController(vsync: vsync, duration: _defaultDuration);

    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller!);

    _scale = Tween<double>(
      begin: 0.8,
      end: 1,
    ).chain(CurveTween(curve: Curves.elasticOut)).animate(_controller!);
  }

  /// 🎞️ Triggers the animation forward
  @override
  void play({Duration? durationOverride}) => _controller!.forward(from: 0);

  ///
  @override
  Future<void> reverse() async => _controller!.reverse();

  /// 🎛️ Getters for external binding (FadeTransition, ScaleTransition)
  @override
  Animation<double> get opacity => _opacity;

  @override
  Animation<double> get scale => _scale;

  /// 🛑 Safely disposes animation controller
  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }

  ///
}
