import 'package:firebase_with_bloc_or_cubit/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../../overlays/core/enums_for_overlay_module.dart';
import '__animation_engine.dart';
import 'ios_animation_engine.dart';
import 'android_animation_engine.dart';

/// 🎯 [OverlayEngineX] — resolves the correct animation engine
/// based on overlay category and platform.
/// Clean, centralized switch logic for easy extendability.
extension OverlayEngineX on BuildContext {
  AnimationEngine getEngine(OverlayCategory type) {
    return switch ((type, platform)) {
      // 🍎 iOS: use shared configurable engine
      (OverlayCategory.dialog, TargetPlatform.iOS) => IOSOverlayAnimationEngine(
        ShowAs.dialog,
      ),
      (OverlayCategory.banner, TargetPlatform.iOS) => IOSOverlayAnimationEngine(
        ShowAs.banner,
      ),
      (OverlayCategory.snackbar, TargetPlatform.iOS) =>
        IOSOverlayAnimationEngine(ShowAs.snackbar),

      // 🤖 Android: use shared configurable engine
      (OverlayCategory.dialog, TargetPlatform.android) =>
        AndroidOverlayAnimationEngine(ShowAs.dialog),
      (OverlayCategory.banner, TargetPlatform.android) =>
        AndroidOverlayAnimationEngine(ShowAs.banner),
      (OverlayCategory.snackbar, TargetPlatform.android) =>
        AndroidOverlayAnimationEngine(ShowAs.snackbar),

      // 🛑 Default fallback
      _ => FallbackAnimationEngine(),

      ///
    };
  }
}
