import 'package:firebase_with_bloc_or_cubit/core/base_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';
import '../../overlays/core/enums_for_overlay_module.dart';
import '../module_core/_animation_engine.dart';
import 'overlays_animation_engines/ios_animation_engine.dart';
import 'overlays_animation_engines/android_animation_engine.dart';

/// 🎯 [OverlayAnimationEngineMapperX] — resolves the animation engine,
///     based on overlay category and platform.
//
extension OverlayAnimationEngineMapperX on BuildContext {
  ///-------------------------------------------------
  //
  AnimationEngine getEngine(OverlayCategory type) {
    return switch ((type, platform)) {
      //
      // 🍎 iOS: use shared configurable engine
      (OverlayCategory.dialog, TargetPlatform.iOS) => IOSOverlayAnimationEngine(
        ShowAs.dialog,
      ),

      (OverlayCategory.banner, TargetPlatform.iOS) => IOSOverlayAnimationEngine(
        ShowAs.banner,
      ),

      (OverlayCategory.snackbar, TargetPlatform.iOS) =>
        IOSOverlayAnimationEngine(ShowAs.snackbar),

      ////

      // 🤖 Android: use shared configurable engine
      (OverlayCategory.dialog, TargetPlatform.android) =>
        AndroidOverlayAnimationEngine(ShowAs.dialog),

      (OverlayCategory.banner, TargetPlatform.android) =>
        AndroidOverlayAnimationEngine(ShowAs.banner),

      (OverlayCategory.snackbar, TargetPlatform.android) =>
        AndroidOverlayAnimationEngine(ShowAs.snackbar),

      ////

      // 🛑 Default fallback
      _ => FallbackAnimationEngine(),

      //
    };
  }
}
