import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlay/core/context_overlay_x.dart';
import 'package:flutter/material.dart';
import '../../errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import '../presentation/overlay_entries/_overlay_entries.dart';
import 'overlay_message_key.dart';
import '../presentation/overlay_presets/overlay_presets.dart';

/// 🎯 [OverlayController] — Central high-level API for triggering UI overlays
/// ✅ Decouples UI call sites from internal dispatcher logic
/// ✅ Automatically uses extensible presets when available
/// ✅ Platform-aware rendering using sealed entries
///-------------------------------------------------------------

final class OverlayController {
  final BuildContext _context;
  const OverlayController(this._context);

  /// 🧩 Shows a loading spinner for a given [duration]
  void showLoader({Duration duration = const Duration(seconds: 2)}) {
    final platform = Theme.of(_context).platform;
    final entry = switch (platform) {
      TargetPlatform.android => AndroidLoaderOverlayEntry(duration: duration),
      TargetPlatform.iOS => IOSLoaderOverlayEntry(duration: duration),
      _ => IOSLoaderOverlayEntry(duration: duration),
    };
    _context.overlayDispatcher.enqueueRequest(_context, entry);
  }

  /// 🍞 Shows a platform-aware snackbar (iOS/Android) using optional preset
  void showSnackbar({
    required String message,
    OverlayMessageKey? messageKey,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
    bool isError = false,
    IconData? icon,
  }) {
    final platform = Theme.of(_context).platform;
    final entry = switch (platform) {
      TargetPlatform.android => AndroidSnackbarOverlayEntry(
        message,
        preset: preset,
        messageKey: messageKey,
        isError: isError,
        icon: icon,
      ),
      TargetPlatform.iOS => IOSSnackbarOverlayEntry(
        message,
        preset: preset,
        messageKey: messageKey,
        isError: isError,
        icon: icon,
      ),
      _ => IOSSnackbarOverlayEntry(
        message,
        preset: preset,
        messageKey: messageKey,
        isError: isError,
        icon: icon,
      ),
    };
    _context.overlayDispatcher.enqueueRequest(_context, entry);
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
    final platform = Theme.of(_context).platform;
    final entry = switch (platform) {
      TargetPlatform.android => AndroidDialogOverlayEntry(
        title,
        content,
        confirmText: confirmText ?? 'OK',
        cancelText: cancelText ?? 'Cancel',
        onConfirm: onConfirm,
        onCancel: onCancel,
        preset: preset,
        isError: isError,
      ),
      TargetPlatform.iOS => IOSDialogOverlayEntry(
        title,
        content,
        confirmText: confirmText ?? 'OK',
        cancelText: cancelText ?? 'Cancel',
        onConfirm: onConfirm,
        onCancel: onCancel,
        preset: preset,
        isError: isError,
      ),
      _ => IOSDialogOverlayEntry(
        title,
        content,
        confirmText: confirmText ?? 'OK',
        cancelText: cancelText ?? 'Cancel',
        onConfirm: onConfirm,
        onCancel: onCancel,
        preset: preset,
        isError: isError,
      ),
    };
    _context.overlayDispatcher.enqueueRequest(_context, entry);
  }

  /// 🪧 Shows a platform-aware banner (iOS/Android) using optional preset
  void showBanner({
    required OverlayMessageKey key,
    required IconData icon,
    OverlayUIPresets? preset,
    bool isError = false,
  }) {
    final message = key.localize(_context);
    final platform = Theme.of(_context).platform;
    final entry = switch (platform) {
      TargetPlatform.android => AndroidBannerOverlayEntry(
        message,
        key,
        preset: preset,
        isError: isError,
        icon: icon,
      ),
      TargetPlatform.iOS => IOSBannerOverlayEntry(
        message,
        key,
        preset: preset,
        isError: isError,
        icon: icon,
      ),
      _ => IOSBannerOverlayEntry(
        message,
        key,
        preset: preset,
        isError: isError,
        icon: icon,
      ),
    };
    _context.overlayDispatcher.enqueueRequest(_context, entry);
  }

  /// 🧠 Handles displaying [FailureUIModel] as banner/snackbar/dialog
  /// 📌 Uses [OverlayUIPresets] and [ShowErrorAs] to configure appearance and behavior
  void showError(
    FailureUIModel model, {
    BuildContext? overrideContext,
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
          content: key?.localize(_context) ?? model.fallbackMessage,
          confirmText: 'Ok',
          cancelText: 'Cancel',
          preset: preset,
          isError: true,
        );
        break;
    }
  }

  ///
  /// 🧱 Shows any custom widget inside overlay (platform-aware container)
  void showCustomOverlay({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
  }) {
    final platform = Theme.of(_context).platform;
    final entry = switch (platform) {
      TargetPlatform.android => AndroidCustomOverlayEntry(
        child,
        duration: duration,
      ),
      TargetPlatform.iOS => IOSCustomOverlayEntry(child, duration: duration),
      _ => IOSCustomOverlayEntry(child, duration: duration),
    };
    _context.overlayDispatcher.enqueueRequest(_context, entry);
  }

  //
}

/// 📌 Specifies how to display an error in UI
enum ShowErrorAs { banner, snackbar, dialog }
