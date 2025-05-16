import 'package:flutter/material.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '../presentation/overlay_presets/preset_props.dart';
import 'queue_manager/banner_overlay_job.dart';
import 'queue_manager/_queue_manager.dart';
import 'queue_manager/dialog_overlay_job.dart';
import 'queue_manager/snackbar_overlay_job.dart';

extension UserOverlayContextX on BuildContext {
  void showUserBanner(String message, IconData icon) {
    di<OverlayQueueManager>().enqueue(
      BannerOverlayJob(context: this, message: message, icon: icon),
    );
  }

  void showUserSnackbar({
    required String message,
    required IconData icon,
    OverlayUIPresetProps? presetProps,
    TargetPlatform? platform,
  }) {
    di<OverlayQueueManager>().enqueue(
      SnackbarOverlayJob(
        context: this,
        message: message,
        icon: icon,
        presetProps: presetProps,
        platform: platform,
      ),
    );
  }

  void showUserDialog({
    required String title,
    required String content,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresetProps? presetProps,
    TargetPlatform? platform,
    bool isInfoDialog = false,
  }) {
    di<OverlayQueueManager>().enqueue(
      DialogOverlayJob(
        context: this,
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        presetProps: presetProps,
        platform: platform,
        isInfoDialog: isInfoDialog,
      ),
    );
  }
}
