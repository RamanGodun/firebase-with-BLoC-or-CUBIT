import 'package:flutter/material.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '../presentation/overlay_presets/preset_props.dart';
import 'overlay_tasks/banner_overlay_task.dart';
import '_queue_manager.dart';
import 'overlay_tasks/dialog_overlay_task.dart';
import 'overlay_tasks/snackbar_overlay_task.dart';

/// 🧭 [ContextXForUserDrivenOverlayFlow] — Extension for user-initiated overlays
/// - Dispatches overlay tasks (dialog, banner, snackbar) via [OverlayQueueManager]
/// - Safe to use from button taps, gestures, or inline UI triggers
/// - Each task is queued and animated using [AnimationHost]
// ----------------------------------------------------------------------

extension ContextXForUserDrivenOverlayFlow on BuildContext {
  //
  /// 🪧 Shows a banner overlay triggered manually by user
  void showUserBanner(String message, IconData icon) {
    di<OverlayQueueManager>().enqueue(
      BannerOverlayTask(context: this, message: message, icon: icon),
    );
  }

  /// 🍞 Shows a snackbar overlay with optional [presetProps] and platform override
  void showUserSnackbar({
    required String message,
    required IconData icon,
    OverlayUIPresetProps? presetProps,
    TargetPlatform? platform,
  }) {
    di<OverlayQueueManager>().enqueue(
      SnackbarOverlayTask(
        context: this,
        message: message,
        icon: icon,
        presetProps: presetProps,
        platform: platform,
      ),
    );
  }

  /// 💬 Shows a platform-adaptive dialog with optional confirm/cancel logic
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
      DialogOverlayTask(
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
