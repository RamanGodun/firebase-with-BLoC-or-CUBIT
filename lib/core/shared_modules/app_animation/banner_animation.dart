import 'package:flutter/material.dart';

final class BannerAnimationService {
  AnimationController? _controller;

  /// Must be called in overlay build (pass vsync from OverlayWidget)
  AnimationController init(TickerProvider vsync) {
    dispose(); // avoid leaks

    _controller = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 600),
    );

    return _controller!;
  }

  Animation<double> opacity() => Tween<double>(
    begin: 0,
    end: 1,
  ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller!);

  Animation<double> scale() => Tween<double>(
    begin: 0.8,
    end: 1,
  ).chain(CurveTween(curve: Curves.elasticOut)).animate(_controller!);

  void dispose() {
    _controller?.dispose();
    _controller = null;
  }

  bool get isActive => _controller?.isAnimating ?? false;
}
