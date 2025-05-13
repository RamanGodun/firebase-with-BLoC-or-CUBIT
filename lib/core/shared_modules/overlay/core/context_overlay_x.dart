import 'package:flutter/material.dart';
import '../../../app_config/bootstrap/di_container.dart';
import '../../errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import '../presentation/overlay_entries/_overlay_entries.dart';
import '../presentation/overlay_presets/overlay_presets.dart';
import '../overlay_dispatcher/overlay_dispatcher_contract.dart';
import 'overlay_message_key.dart';

/// 🎯 [OverlayContextX] — Unified extension for overlay DSL and dispatcher access
/// ✅ Use `context.showSnackbar(...)` / `context.showBanner(...)` directly
/// ✅ No need to use intermediate `OverlayController`
//-------------------------------------------------------------

extension OverlayContextX on BuildContext {
  ///

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
    required OverlayMessageKey key,
    required IconData icon,
    OverlayUIPresets? preset,
    bool isError = false,
  }) {
    final message = key.localize(this);
    final entry = BannerOverlayEntry(
      message,
      key,
      preset: preset,
      isError: isError,
      icon: icon,
    );
    overlayDispatcher.enqueueRequest(this, entry);
  }

  /// 🍞 Shows a platform-aware snackbar (iOS/Android) using optional preset
  void showSnackbar({
    required String message,
    OverlayMessageKey? messageKey,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    IconData? icon,
  }) {
    final entry = SnackbarOverlayEntry(
      message,
      messageKey: messageKey,
      preset: preset,
      isError: isError,
      icon: icon,
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
    OverlayUIPresets? preset,
    bool isError = false,
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
    );
    overlayDispatcher.enqueueRequest(this, entry);
  }

  /// 🧠 Handles displaying [FailureUIModel] as banner/snackbar/dialog
  /// 📌 Uses [OverlayUIPresets] and [ShowErrorAs] to configure appearance and behavior
  void showError(
    FailureUIModel model, {
    ShowErrorAs showAs = ShowErrorAs.dialog,
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
  }) {
    final key =
        model.translationKey == null
            ? null
            : StaticOverlayMessageKey(
              model.translationKey!,
              fallback: model.fallbackMessage,
            );

    switch (showAs) {
      case ShowErrorAs.banner:
        showBanner(
          key:
              key ??
              StaticOverlayMessageKey(
                'error.unknown',
                fallback: model.fallbackMessage,
              ),
          icon: model.icon,
          preset: preset,
          isError: true,
        );
        break;
      case ShowErrorAs.snackbar:
        showSnackbar(
          message: model.fallbackMessage,
          messageKey: key,
          preset: preset,
          isError: true,
          icon: model.icon,
        );
        break;
      case ShowErrorAs.dialog:
        showDialog(
          title: 'Error occurred',
          content: key?.localize(this) ?? model.fallbackMessage,
          confirmText: 'Ok',
          cancelText: 'Cancel',
          preset: preset,
          isError: true,
        );
        break;
    }
  }

  /// 🧱 Shows any custom widget inside overlay (platform-aware container)
  void showCustomOverlay({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
  }) {
    final entry = CustomOverlayEntry(child: child, duration: duration);
    overlayDispatcher.enqueueRequest(this, entry);
  }

  ///
}

///
/// 📌 Specifies how to display an error in UI
enum ShowErrorAs { banner, snackbar, dialog }
