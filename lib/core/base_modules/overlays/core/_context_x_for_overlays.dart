import 'package:firebase_with_bloc_or_cubit/core/base_modules/overlays/core/_overlay_base_methods.dart';
import 'package:flutter/material.dart';
import '../../../../app_bootstrap_and_config/di_container/di_container.dart';
import '../../errors_handling/failures/failure_ui_model.dart';
import '../../localization/app_localizer.dart';
import '../../localization/generated/locale_keys.g.dart';
import '../overlay_dispatcher/_overlay_dispatcher.dart';
import '../overlays_presentation/overlay_presets/overlay_presets.dart';
import 'enums_for_overlay_module.dart';

/// 🎯 [ContextXForOverlays] — Unified extension for overlay DSL and dispatcher access
/// ✅ Use `context.showSnackbar(...)` / `context.showBanner(...)` directly

extension ContextXForOverlays on BuildContext {
  ///----------------------------------------

  /// 🔌 Lazily access the shared [IOverlayDispatcher] via DI container
  OverlayDispatcher get dispatcher => di<OverlayDispatcher>();

  ////

  /// 🧠 Handles displaying [FailureUIEntity] as banner/snackbar/dialog
  /// 📌 Uses [OverlayUIPresets] and [ShowAs] to configure appearance and behavior
  void showError(
    FailureUIEntity model, {
    ShowAs showAs = ShowAs.infoDialog,
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
    bool isDismissible = false,
    OverlayPriority priority = OverlayPriority.high,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String? confirmText,
    String? cancelText,
  }) {
    //
    ///
    switch (showAs) {
      case ShowAs.banner:
        showBanner(
          message: model.localizedMessage,
          icon: model.icon,
          preset: preset,
          isError: true,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
      case ShowAs.snackbar:
        showSnackbar(
          message: model.localizedMessage,
          preset: preset,
          isError: true,
          icon: model.icon,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
      case ShowAs.dialog:
        showAppDialog(
          title: AppLocalizer.translateSafely(
            LocaleKeys.errors_errors_general_title,
          ),
          content: model.localizedMessage,
          confirmText:
              confirmText ??
              AppLocalizer.translateSafely(LocaleKeys.buttons_ok),
          cancelText:
              cancelText ??
              AppLocalizer.translateSafely(LocaleKeys.buttons_cancel),
          onConfirm: onConfirm,
          onCancel: onCancel,
          preset: preset,
          isError: true,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
      case ShowAs.infoDialog:
        showAppDialog(
          isInfoDialog: true,
          title: AppLocalizer.translateSafely(
            LocaleKeys.errors_errors_general_title,
          ),
          content: model.localizedMessage,
          confirmText: AppLocalizer.translateSafely(LocaleKeys.buttons_ok),
          cancelText: AppLocalizer.translateSafely(LocaleKeys.buttons_cancel),
          onConfirm: onConfirm,
          onCancel: onCancel,
          preset: preset,
          isError: false,
          isDismissible: isDismissible,
          priority: priority,
        );
        break;
      //
    }
  }

  ////

  /// 💬 Shows a platform-adaptive dialog manually triggered by user
  void showUserDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isDismissible = true,
    bool isInfoDialog = false,
  }) {
    showAppDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      preset: preset,
      isError: false,
      isDismissible: isDismissible,
      isInfoDialog: isInfoDialog,
      priority: OverlayPriority.userDriven,
    );
  }

  ////

  /// 🪧 Shows a banner overlay triggered manually by user
  void showUserBanner({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isDismissible = true,
  }) {
    showBanner(
      message: message,
      icon: icon,
      preset: preset,
      isError: false,
      isDismissible: isDismissible,
      priority: OverlayPriority.userDriven,
    );
  }

  ////

  /// 💬 Shows a platform-adaptive snackbar manually triggered by user
  void showUserSnackbar({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    OverlayPriority priority = OverlayPriority.userDriven,
  }) {
    showSnackbar(
      message: message,
      icon: icon,
      preset: preset,
      isError: false,
      isDismissible: true,
      priority: priority,
    );
  }

  //
}
