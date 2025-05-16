import 'package:flutter/material.dart';
import '__animation_engine_interface.dart';

final class IOSDialogAnimationEngine implements IAnimationEngine {
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
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller!);
    _scale = Tween(
      begin: 0.9,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.decelerate)).animate(_controller!);
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
