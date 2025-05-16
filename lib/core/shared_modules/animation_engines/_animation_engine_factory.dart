import 'package:flutter/material.dart';

import '__animation_engine_interface.dart' show IAnimationEngine;
import 'android_banner_animation_engine.dart';
import 'ios_banner_animation_engine.dart';

///===== OVERLAY TYPES ======/
enum UserDrivenOverlayType {
  banner,
  dialog,
  snackbar,
  // tooltip,
  // toast,
  // systemNotification,
}

///===== PLATFORMS ======/
enum AnimationPlatform { android, ios, adaptive }

/// ===== FACTORY ======/
// (Decides exact animation engine)
final class AnimationEngineFactory {
  const AnimationEngineFactory._();

  static IAnimationEngine create({
    required UserDrivenOverlayType target,
    required AnimationPlatform platform,
    required TickerProvider vsync,
  }) {
    final engine = switch ((target, platform)) {
      (UserDrivenOverlayType.banner, AnimationPlatform.ios) =>
        IOSAnimationBannerEngine(),
      (UserDrivenOverlayType.banner, AnimationPlatform.android) =>
        AndroidBannerAnimationEngine(),
      (UserDrivenOverlayType.banner, AnimationPlatform.adaptive) =>
        IOSAnimationBannerEngine(), // TEMP fallback
      // TODO: add dialog/snackbar entries
      _ => throw UnimplementedError('No animation engine for target/platform'),
    };

    engine.initialize(vsync);
    return engine;
  }
}
