import 'package:flutter/material.dart';
import '../errors_handling/failures_for_domain_and_presentation/failure_ui_model.dart';
import 'core/overlay_dispatcher.dart';
import 'core/overlay_message_key.dart';
import 'core/overlay_requests.dart';
import 'core/overlay_presets.dart';
import 'presentation/widgets/animated_kind_banner.dart';
import 'presentation/widgets/platform_dialog_widget.dart';

// ✅ DSL Entry Point
extension OverlayDSL on BuildContext {
  OverlayController get overlay => OverlayController(this);
}

// 🛡️ Dispatcher bridge
extension _OverlayDispatcherX on BuildContext {
  void _showOverlayRequest(OverlayAction request) =>
      OverlayDispatcher.instance.enqueueRequest(this, request);
}

// 🎛️ Central Overlay Controller
final class OverlayController {
  final BuildContext _context;
  const OverlayController(this._context);

  void snackbar(String message) =>
      _context._showOverlayRequest(SnackbarOverlay.from(message));

  void dialog({
    required String title,
    required String content,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    OverlayPresets preset = const OverlayInfoPreset(),
  }) {
    _context._showOverlayRequest(
      DialogOverlay(
        PlatformDialogWidget(
          title: title,
          content: content,
          confirmText: confirmText,
          cancelText: cancelText,
          onConfirm: onConfirm,
          onCancel: onCancel,
          icon: preset.icon,
          color: preset.color,
        ),
      ),
    );
  }

  ///
  void loader({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
  }) => _context._showOverlayRequest(LoaderOverlay(child, duration: duration));

  ///
  void showBanner({required OverlayPresets preset, required String message}) {
    final key = StaticOverlayMessageKey(
      'overlay.kind.${preset.runtimeType}',
      fallback: message,
    );
    _context._showOverlayRequest(
      BannerOverlay(
        AnimatedKindBanner(message: message, preset: preset),
        duration: preset.duration,
        messageKey: key,
      ),
    );
  }

  ///
  void showBannerWidget(
    Widget banner, {
    Duration duration = const Duration(seconds: 2),
  }) => _context._showOverlayRequest(BannerOverlay(banner, duration: duration));

  ///
  void themeBanner({required OverlayMessageKey key, required IconData icon}) =>
      _context._showOverlayRequest(
        ThemedBannerOverlay(key.localize(_context), icon, messageKey: key),
      );

  ///
  void showRequest(OverlayAction request) {
    _context._showOverlayRequest(request);
  }

  ///
  // 🧩 Enhanced error handler
  void showError(
    FailureUIModel model, {
    BuildContext? overrideContext,
    ShowAs showAs = ShowAs.banner,
    OverlayPresets preset = const OverlayErrorPreset(),
  }) {
    ///
    final ctx = overrideContext ?? _context;
    final key =
        model.translationKey == null
            ? null
            : StaticOverlayMessageKey(
              model.translationKey!,
              fallback: model.fallbackMessage,
            );

    ///
    switch (showAs) {
      //
      case ShowAs.banner:
        showBanner(preset: preset, message: model.fallbackMessage);
        break;
      //
      case ShowAs.snackbar:
        ctx._showOverlayRequest(
          SnackbarOverlay.from(
            model.fallbackMessage,
            context: ctx,
            icon: model.icon,
            preset: preset,
            key: key,
          ),
        );
        break;
      //
      case ShowAs.dialog:
        dialog(
          title: preset.title,
          content: key?.localize(_context) ?? model.fallbackMessage,
          confirmText: preset.confirmText,
          cancelText: preset.cancelText ?? 'Cancel',
          preset: preset,
        );
        break;
      //
    }
  }

  ///
}

/// 📌 Type of how to show error in the UI
enum ShowAs { banner, snackbar, dialog }
