import 'package:flutter/material.dart';
import '../../app_overlays/core/overlay_enums.dart';
import '_animation_engine.dart';

extension OverlayEngineX on BuildContext {
  DialogAnimationEngine getEngine(OverlayCategory type) {
    final platform = Theme.of(this).platform;

    return switch ((type, platform)) {
      (OverlayCategory.dialog, TargetPlatform.iOS) =>
        IOSDialogAnimationEngine(),
      (OverlayCategory.dialog, TargetPlatform.android) =>
        AndroidDialogAnimationEngine(),
      // (OverlayCategory.snackbar, TargetPlatform.iOS) =>
      //   IOSSnackbarAnimationEngine(),
      // (OverlayCategory.snackbar, TargetPlatform.android) =>
      //   AndroidSnackbarAnimationEngine(),
      // ... розширення для banner, інші
      _ => AndroidDialogAnimationEngine(), // fallback
    };
  }
}
