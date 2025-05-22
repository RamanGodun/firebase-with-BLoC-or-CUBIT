import 'package:flutter/material.dart';
import '../../../overlays/core/overlay_core_types.dart';
import '__animation_engine.dart';
import 'engine_configs.dart';

/// 🌟 [AndroidOverlayAnimationEngine] — unified animation engine for all Android overlays
/// ✅ Centralized engine supporting dialog, banner, snackbar animations via [ShowAs] config
///----------------------------------------------------------------
final class AndroidOverlayAnimationEngine extends BaseAnimationEngine {
  AndroidOverlayAnimationEngine(this.overlayType)
    : _config = _resolveConfig(overlayType);

  final ShowAs overlayType;
  final AndroidOverlayAnimationConfig _config;

  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  Animation<Offset>? _slide;

  /// 🧠 Resolves preset animation configuration based on [ShowAs]
  static AndroidOverlayAnimationConfig _resolveConfig(ShowAs type) {
    return switch (type) {
      ShowAs.banner => const AndroidOverlayAnimationConfig(
        duration: Duration(milliseconds: 400),
        fastDuration: Duration(milliseconds: 160),
        opacityCurve: Curves.easeOut,
        scaleBegin: 0.98,
        scaleCurve: Curves.decelerate,
        slideCurve: Curves.easeOut,
        slideOffset: Offset(0, -0.06),
      ),
      ShowAs.snackbar => const AndroidOverlayAnimationConfig(
        duration: Duration(milliseconds: 450),
        fastDuration: Duration(milliseconds: 160),
        opacityCurve: Curves.easeInOut,
        scaleBegin: 0.96,
        scaleCurve: Curves.easeOut,
        slideCurve: Curves.easeOut,
        slideOffset: Offset(0, 0.1),
      ),
      ShowAs.dialog || ShowAs.infoDialog => const AndroidOverlayAnimationConfig(
        duration: Duration(milliseconds: 400),
        fastDuration: Duration(milliseconds: 180),
        opacityCurve: Curves.easeOut,
        scaleBegin: 0.95,
        scaleCurve: Curves.easeOut,
        slideCurve: Curves.easeOut,
        slideOffset: Offset(0, 0.12),
      ),
    };
  }

  @override
  Duration get defaultDuration => _config.duration;

  @override
  Duration get fastReverseDuration => _config.fastDuration;

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

    if (_config.slideOffset != null && _config.slideCurve != null) {
      _slide = Tween(
        begin: _config.slideOffset!,
        end: Offset.zero,
      ).chain(CurveTween(curve: _config.slideCurve!)).animate(controller);
    }
  }

  @override
  Animation<double> get opacity => _opacity;

  @override
  Animation<double> get scale => _scale;

  @override
  Animation<Offset>? get slide => _slide;
}
