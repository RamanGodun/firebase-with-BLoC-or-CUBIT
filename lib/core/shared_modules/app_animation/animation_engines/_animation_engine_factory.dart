import 'package:flutter/material.dart';
import '../enums_for_animation_module.dart';
import '__animation_engine_interface.dart' show IAnimationEngine;
import 'engines_for_android_platform/android_banner_animation_engine.dart';
import 'engines_for_android_platform/android_dialog_animation_engine.dart';
import 'engines_for_android_platform/android_snackbar_animation_engine.dart';
import 'fallback_animation_engine.dart';
import 'engines_for_ios_platform/ios_banner_animation_engine.dart';
import 'engines_for_ios_platform/ios_dialog_animation_engine.dart';
import 'engines_for_ios_platform/ios_snackbar_animation_engine.dart';

/// 🎬 [AnimationEngineFactory] — Centralized factory for creating animation engines
/// - Selects platform-specific engine based on overlay type and target platform
/// - Normalizes `adaptive` platform to iOS by default
/// - Initializes engine with TickerProvider before returning
/// 🏗️ Static factory to resolve platform-aware animation engine
//----------------------------------------------------------

final class AnimationEngineFactory {
  const AnimationEngineFactory._();

  /// 🎯 Resolves appropriate [IAnimationEngine] for given [UserDrivenOverlayType] and [AnimationPlatform]
  /// - Normalizes [AnimationPlatform.adaptive] to iOS
  /// - Initializes engine with [TickerProvider] before use
  static IAnimationEngine create({
    required UserDrivenOverlayType target,
    required AnimationPlatform platform,
    required TickerProvider vsync,
  }) {
    // 🎛️ Normalize adaptive platform to iOS as default behavior
    final normalizedPlatform =
        platform == AnimationPlatform.adaptive
            ? AnimationPlatform.ios
            : platform;

    final engine = switch ((target, normalizedPlatform)) {
      // 🪧 Banner overlays
      (UserDrivenOverlayType.banner, AnimationPlatform.ios) =>
        IOSAnimationBannerEngine(),
      (UserDrivenOverlayType.banner, AnimationPlatform.android) =>
        AndroidBannerAnimationEngine(),

      // 🍞 Snackbar overlays
      (UserDrivenOverlayType.snackbar, AnimationPlatform.ios) =>
        IOSSnackbarAnimationEngine(),
      (UserDrivenOverlayType.snackbar, AnimationPlatform.android) =>
        AndroidSnackbarAnimationEngine(),

      // 💬 Dialog overlays
      (UserDrivenOverlayType.dialog, AnimationPlatform.ios) =>
        IOSDialogAnimationEngine(),
      (UserDrivenOverlayType.dialog, AnimationPlatform.android) =>
        AndroidDialogAnimationEngine(),

      // 🛑 Fallback engine (should rarely occur)
      _ => FallbackAnimationEngine(),
    };

    engine.initialize(vsync);
    return engine;
  }

  //
}
