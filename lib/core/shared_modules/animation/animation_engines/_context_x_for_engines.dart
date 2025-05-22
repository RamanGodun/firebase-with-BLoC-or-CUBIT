import 'package:flutter/material.dart';
import '../../overlays/core/overlay_enums.dart';
import '_animation_engine.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';

extension OverlayEngineX on BuildContext {
  AnimationEngine getEngine(OverlayCategory type) {
    return switch ((type, platform)) {
      //
      (OverlayCategory.dialog, TargetPlatform.iOS) =>
        IOSDialogAnimationEngine(),
      (OverlayCategory.dialog, TargetPlatform.android) =>
        AndroidDialogAnimationEngine(),

      ///
      (OverlayCategory.banner, TargetPlatform.iOS) =>
        IOSBannerAnimationEngine(),
      (OverlayCategory.banner, TargetPlatform.android) =>
        AndroidBannerAnimationEngine(),

      ///
      (OverlayCategory.snackbar, TargetPlatform.iOS) =>
        IOSSnackbarAnimationEngine(),
      (OverlayCategory.snackbar, TargetPlatform.android) =>
        AndroidSnackbarAnimationEngine(),

      /// Fallback
      _ => FallbackAnimationEngine(),
    };
  }
}
