import 'package:flutter/material.dart';

part 'android_dialog_engine.dart';
part 'ios_dialog_engine.dart';

/// 🎯 [DialogAnimationEngine] — base class for platform-specific dialog animations
/// ✅ Used in overlays to drive platform-native transitions
/// ✅ Provides core animation lifecycle and properties
sealed class DialogAnimationEngine {
  /// 🎛️ Must initialize controllers & tweens with proper [TickerProvider]
  void initialize(TickerProvider vsync);

  /// ▶️ Starts forward animation from initial state
  void play({Duration? durationOverride});

  /// ⏪ Reverses animation with optional fast collapse for dismissal
  Future<void> reverse({bool fast});

  /// 🛑 Disposes animation controllers and internal resources
  void dispose();

  /// 🌫️ Opacity animation (used for fade transitions)
  Animation<double> get opacity;

  /// 🔍 Scale animation (used for zoom in/out)
  Animation<double> get scale;

  /// ↕️ Optional slide animation (e.g., Android bottom-to-center)
  /// Defaults to `null` if not supported
  Animation<Offset>? get slide => null;
}
