import 'package:flutter/material.dart';

import '../presentation/overlay_presets/preset_props.dart';
import 'overlay_service.dart';

extension UserOverlayContextX on BuildContext {
  /// 🔁 Replaces active banner with a new one
  void showUserBanner(String message, IconData icon) =>
      OverlayService.showBanner(this, message, icon);

  /// 🧾 Shows a dialog with optional confirm/cancel actions
  Future<void> showUserDialog({
    required String title,
    required String content,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresetProps? presetProps,
    TargetPlatform? platform,
    bool isInfoDialog = false,
  }) => OverlayService.showAppDialog(
    this,
    title: title,
    content: content,
    confirmText: confirmText,
    cancelText: cancelText,
    onConfirm: onConfirm,
    onCancel: onCancel,
    presetProps: presetProps,
    platform: platform,
    isInfoDialog: isInfoDialog,
  );

  /// 🍞 Shows a snackbar styled per platform
  void showUserSnackbar({
    required String message,
    required IconData icon,
    OverlayUIPresetProps? presetProps,
    TargetPlatform? platform,
  }) => OverlayService.showSnackbar(
    this,
    message: message,
    icon: icon,
    presetProps: presetProps,
    platform: platform,
  );
}
