import 'package:flutter/material.dart';

abstract interface class IAnimationEngine {
  void initialize(TickerProvider vsync);
  void play({Duration? durationOverride});
  Future<void> reverse();
  void dispose();
  Animation<double> get opacity;
  Animation<double> get scale;
}

abstract interface class ISlideAnimationEngine implements IAnimationEngine {
  Animation<Offset> get slide;
}