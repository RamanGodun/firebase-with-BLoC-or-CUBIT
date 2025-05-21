import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_overlays/presentation/widgets/ios_dialog.dart'
    show IOSAppDialog;
import 'package:flutter/material.dart';
import '../../app_animation/new_engines/_animation_engine.dart';
import '../presentation/overlay_presets/preset_props.dart';
import '../presentation/widgets/android_dialog.dart';

abstract final class PlatformMapper {
  PlatformMapper._();

  ///
  static Widget resolveAppDialog({
    required TargetPlatform platform,
    required DialogAnimationEngine engine,
    required String title,
    required String content,
    required String confirmText,
    required String cancelText,
    required VoidCallback? onConfirm,
    required VoidCallback? onCancel,
    required OverlayUIPresetProps presetProps,
    required bool isInfoDialog,
    required bool isFromUserFlow,
  }) {
    return switch (platform) {
      TargetPlatform.iOS => IOSAppDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        presetProps: presetProps,
        isInfoDialog: isInfoDialog,
        isFromUserFlow: isFromUserFlow,
        engine: engine,
      ),
      TargetPlatform.android => AndroidDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        presetProps: presetProps,
        isInfoDialog: isInfoDialog,
        isFromUserFlow: isFromUserFlow,
        engine: engine,
      ),
      _ => IOSAppDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        presetProps: presetProps,
        isInfoDialog: isInfoDialog,
        isFromUserFlow: isFromUserFlow,
        engine: engine,
      ),
    };
  }

  ///
}
