import 'package:flutter/material.dart';

/// 🧩 Interface for centralized animation control
abstract interface class IAnimationEngine {
  void initialize(TickerProvider vsync);
  void play({Duration? durationOverride});
  Animation<double> get opacity;
  Animation<double> get scale;
  void dispose();
}
