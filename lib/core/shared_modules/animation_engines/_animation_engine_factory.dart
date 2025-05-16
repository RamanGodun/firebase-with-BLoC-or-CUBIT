import 'package:flutter/material.dart';

import '__animation_engine_interface.dart' show IAnimationEngine;
import 'android_banner_animation_engine.dart';
import 'android_dialog_animation_engine.dart';
import 'android_snackbar_animation_engine.dart';
import 'fallback_animation_engine.dart';
import 'ios_banner_animation_engine.dart';
import 'ios_dialog_animation_engine.dart';
import 'ios_snackbar_animation_engine.dart';

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

final class AnimationEngineFactory {
  const AnimationEngineFactory._();

  static IAnimationEngine create({
    required UserDrivenOverlayType target,
    required AnimationPlatform platform,
    required TickerProvider vsync,
  }) {
    final normalizedPlatform =
        platform == AnimationPlatform.adaptive
            ? AnimationPlatform.ios
            : platform;

    final engine = switch ((target, normalizedPlatform)) {
      (UserDrivenOverlayType.banner, AnimationPlatform.ios) =>
        IOSAnimationBannerEngine(),
      (UserDrivenOverlayType.banner, AnimationPlatform.android) =>
        AndroidBannerAnimationEngine(),

      (UserDrivenOverlayType.snackbar, AnimationPlatform.ios) =>
        IOSSnackbarAnimationEngine(),
      (UserDrivenOverlayType.snackbar, AnimationPlatform.android) =>
        AndroidSnackbarAnimationEngine(),

      (UserDrivenOverlayType.dialog, AnimationPlatform.ios) =>
        IOSDialogAnimationEngine(),
      (UserDrivenOverlayType.dialog, AnimationPlatform.android) =>
        AndroidDialogAnimationEngine(),

      _ => FallbackAnimationEngine(),
    };
    engine.initialize(vsync);
    return engine;
  }

  //
}
