import 'package:flutter/material.dart';

import 'animation_engine_interface.dart' show IAnimationEngine;

// === OVERLAY TYPES ===
enum OverlayType {
  banner,
  dialog,
  snackbar,
  // tooltip,
  // toast,
  // systemNotification,
}

enum AnimationTargetType {
  banner,
  dialog,
  snackbar,
  // tooltip,
  // toast,
  // systemNotification,
}

enum AnimationPlatform { android, ios, adaptive }

final class AnimationEngine implements IAnimationEngine {
  static const _defaultDuration = Duration(milliseconds: 600);
  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

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

  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  @override
  Future<void> reverse() async => _controller?.reverse();

  @override
  Animation<double> get opacity => _opacity;

  @override
  Animation<double> get scale => _scale;

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}

// === FACTORY ===
final class AnimationEngineFactory {
  const AnimationEngineFactory._();

  static IAnimationEngine create({
    required AnimationTargetType targetType,
    required TickerProvider vsync,
    AnimationPlatform platform = AnimationPlatform.adaptive,
  }) {
    final engine = switch (targetType) {
      AnimationTargetType.banner => AnimationEngine(),
      AnimationTargetType.snackbar => AnimationEngine(),
      AnimationTargetType.dialog => AnimationEngine(),
    };
    engine.initialize(vsync);
    return engine;
  }
}
