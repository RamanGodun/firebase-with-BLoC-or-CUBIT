import 'package:flutter/material.dart';

import '__animation_engine_interface.dart';

final class AndroidSnackbarAnimationEngine implements ISlideAnimationEngine {
  static const _defaultDuration = Duration(milliseconds: 450);
  AnimationController? _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  late final Animation<Offset> _slide;

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

  @override
  void play({Duration? durationOverride}) => _controller?.forward(from: 0);

  @override
  Future<void> reverse() async => _controller?.reverse();

  @override
  Animation<double> get opacity => _opacity;

  @override
  Animation<double> get scale => _scale;

  @override
  Animation<Offset> get slide => _slide;

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
  }
}
