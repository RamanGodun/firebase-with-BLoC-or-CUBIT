import 'package:flutter/material.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '../../errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import 'conflicts_strategy/police_resolver.dart';
import 'overlay_entries/_overlay_entries.dart';
import '../presentation/overlay_presets/overlay_presets.dart';
import 'overlay_dispatcher/overlay_dispatcher_interface.dart';

/// 🎯 [OverlayContextX] — Unified extension for overlay DSL and dispatcher access
/// ✅ Use `context.showSnackbar(...)` / `context.showBanner(...)` directly
/// ✅ No need to use intermediate `OverlayController`
//-------------------------------------------------------------

extension OverlayContextX on BuildContext {
  //
  /// 🔌 Direct access to [IOverlayDispatcher] from DI
  IOverlayDispatcher get overlayDispatcher => di<IOverlayDispatcher>();

  ///
  /// 🧩 Shows a loading spinner for a given [duration]
  void showLoader({Duration duration = const Duration(seconds: 2)}) {
    final entry = LoaderOverlayEntry(duration: duration);
    overlayDispatcher.enqueueRequest(this, entry);
  }

  /// 🪧 Shows a platform-aware banner (iOS/Android) using optional preset
  void showBanner({
    required String message,
    IconData? icon,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
  }) {
    final entry = BannerOverlayEntry(
      message,
      preset: preset,
      isError: isError,
      icon: icon,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
    );
    overlayDispatcher.enqueueRequest(this, entry);
  }

  /// 🍞 Shows a platform-aware snackbar (iOS/Android) using optional preset
  void showSnackbar({
    required String message,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    IconData? icon,
    bool isDismissible = true,
  }) {
    final entry = SnackbarOverlayEntry(
      message,
      preset: preset,
      isError: isError,
      icon: icon,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
    );
    overlayDispatcher.enqueueRequest(this, entry);
  }

  /// 💬 Shows a short platform-adaptive dialog (iOS/Android)
  void showDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    bool isDismissible = true,
  }) {
    final entry = DialogOverlayEntry(
      title,
      content,
      confirmText: confirmText ?? 'OK',
      cancelText: cancelText ?? 'Cancel',
      onConfirm: onConfirm,
      onCancel: onCancel,
      preset: preset,
      isError: isError,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
    );
    overlayDispatcher.enqueueRequest(this, entry);
  }

  /// 🧠 Handles displaying [FailureUIModel] as banner/snackbar/dialog
  /// 📌 Uses [OverlayUIPresets] and [ShowErrorAs] to configure appearance and behavior
  void showError(
    FailureUIModel model, {
    ShowErrorAs showAs = ShowErrorAs.dialog,
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
    bool isDismissible = false,
  }) {
    ///

    switch (showAs) {
      //
      case ShowErrorAs.banner:
        showBanner(
          message: model.localizedMessage,
          icon: model.icon,
          preset: preset,
          isError: true,
          isDismissible: isDismissible,
        );
        break;
      //
      case ShowErrorAs.snackbar:
        showSnackbar(
          message: model.localizedMessage,
          preset: preset,
          isError: true,
          icon: model.icon,
          isDismissible: isDismissible,
        );
        break;
      //
      case ShowErrorAs.dialog:
        showDialog(
          title:
              'Error occurred', // Винести в локалізований ключ `FailureKey.dialogTitleError`
          content: model.localizedMessage,
          confirmText: 'OK',
          cancelText: 'Cancel',
          preset: preset,
          isError: true,
          isDismissible: isDismissible,
        );
        break;
    }
  }

  /// 🧱 Shows any custom widget inside overlay (platform-aware container)
  void showCustomOverlay({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
    bool isDismissible = true,
    bool isError = false,
  }) {
    final entry = CustomOverlayEntry(
      child: child,
      duration: duration,
      isError: isError,
      dismissPolicy: OverlayPolicyResolver.resolveDismissPolicy(isDismissible),
    );
    overlayDispatcher.enqueueRequest(this, entry);
  }

  //
}

///
/// 📌 Specifies how to display an error in UI
enum ShowErrorAs { banner, snackbar, dialog }
