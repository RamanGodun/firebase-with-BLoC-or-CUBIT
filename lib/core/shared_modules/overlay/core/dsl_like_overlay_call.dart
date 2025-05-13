import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlay/core/context_overlay_x.dart';
import 'package:flutter/material.dart';
import '../../errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import 'overlay_entries.dart';
import 'overlay_message_key.dart';
import '../overlay_presets/overlay_presets.dart';
import '../presentation/widgets/animated_kind_banner.dart';

/// 🎯 [OverlayController] — Central high-level API for triggering UI overlays
/// ✅ Decouples UI call sites from internal dispatcher logic
/// ✅ Automatically uses extensible presets when available
///-------------------------------------------------------------

final class OverlayController {
  //
  final BuildContext _context;
  const OverlayController(this._context);

  /// 🧩 Shows a loading spinner for a given [duration]
  void showLoader({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
  }) => _context.overlayDispatcher.enqueueRequest(
    _context,
    LoaderOverlayEntry(child, duration: duration),
  );

  /// 🧩 Shows a styled snackbar with fallback message
  void snackbar(String message) => _context.overlayDispatcher.enqueueRequest(
    _context,
    SnackbarOverlayEntry.from(message),
  );

  /// 🧩 Shows a dialog using either a preset override or default styled dialog
  void showDialog({
    required String title,
    required String content,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayUIPresets preset = const OverlayInfoUIPreset(),
  }) {
    final props = preset.resolve();
    _context.overlayDispatcher.enqueueRequest(
      _context,
      DialogOverlayEntry(
        title: title,
        content: content,
        confirmText: confirmText ?? 'OK',
        cancelText: cancelText ?? 'Cancel',
        onConfirm: onConfirm,
        onCancel: onCancel,
        icon: props.icon,
        color: props.color,
      ),
    );
  }

  /// 🧩 Shows a banner using either a preset override or default styled banner
  void showBanner({required OverlayUIPresets preset, required String message}) {
    final props = preset.resolve();
    final key = StaticOverlayMessageKey(
      'overlay.kind.${preset.runtimeType}',
      fallback: message,
    );

    final banner = AnimatedPresetBanner(message: message, props: props);

    _context.overlayDispatcher.enqueueRequest(
      _context,
      BannerOverlayEntry(banner, duration: props.duration, messageKey: key),
    );
  }

  /// 📦 Shows a custom banner widget for a given [duration]
  void showBannerWidget(
    Widget banner, {
    Duration duration = const Duration(seconds: 2),
  }) => _context.overlayDispatcher.enqueueRequest(
    _context,
    BannerOverlayEntry(banner, duration: duration),
  );

  /// 📦 Shows a themed icon+text banner from a [OverlayMessageKey]
  void themeBanner({required OverlayMessageKey key, required IconData icon}) =>
      _context.overlayDispatcher.enqueueRequest(
        _context,
        ThemedBannerOverlayEntry(key.localize(_context), icon, messageKey: key),
      );

  /// 🧩 Directly triggers a custom overlay request (e.g., custom widget)
  void showRequest(OverlayUIEntry request) {
    _context.overlayDispatcher.enqueueRequest(_context, request);
  }

  /// 🧠 Handles displaying [FailureUIModel] as banner/snackbar/dialog
  /// 📌 Uses [OverlayUIPresets] and [ShowErrorAs] to configure appearance and behavior
  void showError(
    FailureUIModel model, {
    BuildContext? overrideContext,
    ShowErrorAs showAs = ShowErrorAs.banner,
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
  }) {
    final ctx = overrideContext ?? _context;
    final key =
        model.translationKey == null
            ? null
            : StaticOverlayMessageKey(
              model.translationKey!,
              fallback: model.fallbackMessage,
            );

    switch (showAs) {
      case ShowErrorAs.banner:
        showBanner(preset: preset, message: model.fallbackMessage);
        break;
      case ShowErrorAs.snackbar:
        ctx.overlayDispatcher.enqueueRequest(
          ctx,
          SnackbarOverlayEntry.from(
            model.fallbackMessage,
            context: ctx,
            icon: model.icon,
            preset: preset,
            key: key,
          ),
        );
        break;
      case ShowErrorAs.dialog:
        showDialog(
          title: 'Error occurred',
          content: key?.localize(_context) ?? model.fallbackMessage,
          confirmText: 'Ok',
          // cancelText: 'Cancel',
          preset: preset,
        );
        break;
    }
  }
}

/// 📌 Specifies how to display an error in UI
enum ShowErrorAs { banner, snackbar, dialog }
