import 'package:flutter/material.dart';
import '../../../../overlays/core/enums_for_overlay_module.dart';
import '../_animation_engine.dart';
import '../engine_configs.dart';

/// 🍎 [IOSOverlayAnimationEngine] — shared animation engine for all iOS overlays
/// ✅ Uses category-based configuration to generate platform-consistent animations

final class IOSOverlayAnimationEngine extends BaseAnimationEngine {
  ///-------------------------------------------------------------

  // ⚙️ Resolved animation config based on [overlayType]
  final IOSOverlayAnimationConfig _config;
  // 💫 Opacity animation
  late final Animation<double> _opacity;
  // 🔍 Scale animation
  late final Animation<double> _scale;

  /// 🏗️ Constructor, that initializes config from type
  IOSOverlayAnimationEngine(ShowAs overlayType)
    : _config = _resolveConfig(overlayType);

  ///

  /// 🧠 Resolves preset animation configuration based on [ShowAs]
  static IOSOverlayAnimationConfig _resolveConfig(ShowAs overlayType) {
    //
    return switch (overlayType) {
      //
      ShowAs.banner => const IOSOverlayAnimationConfig(
        duration: Duration(milliseconds: 500),
        fastDuration: Duration(milliseconds: 180),
        opacityCurve: Curves.easeInOut,
        scaleBegin: 0.9,
        scaleCurve: Curves.decelerate,
      ),

      ShowAs.dialog => const IOSOverlayAnimationConfig(
        duration: Duration(milliseconds: 500),
        fastDuration: Duration(milliseconds: 180),
        opacityCurve: Curves.easeInOut,
        scaleBegin: 0.9,
        scaleCurve: Curves.decelerate,
      ),

      ShowAs.infoDialog => const IOSOverlayAnimationConfig(
        duration: Duration(milliseconds: 500),
        fastDuration: Duration(milliseconds: 160),
        opacityCurve: Curves.easeOut,
        scaleBegin: 0.92,
        scaleCurve: Curves.easeOutBack,
      ),

      ShowAs.snackbar => const IOSOverlayAnimationConfig(
        duration: Duration(milliseconds: 600),
        fastDuration: Duration(milliseconds: 160),
        opacityCurve: Curves.easeInOut,
        scaleBegin: 0.95,
        scaleCurve: Curves.decelerate,
      ),
    };
  }

  /// ⏱️ Default animation duration
  @override
  Duration get defaultDuration => _config.duration;

  /// ⏩ Fast reverse duration (e.g. for dismiss)
  @override
  Duration get fastReverseDuration => _config.fastDuration;

  /// ⚙️ Sets up tweens for all animations
  @override
  void setupAnimations() {
    _opacity = Tween(
      begin: 0.0,
      end: 1.0,
    ).chain(CurveTween(curve: _config.opacityCurve)).animate(controller);

    _scale = Tween(
      begin: _config.scaleBegin,
      end: 1.0,
    ).chain(CurveTween(curve: _config.scaleCurve)).animate(controller);
  }

  /// 🌫️ Fade transition animation
  @override
  Animation<double> get opacity => _opacity;

  /// 🔍 Scale transition animation
  @override
  Animation<double> get scale => _scale;

  //
}
