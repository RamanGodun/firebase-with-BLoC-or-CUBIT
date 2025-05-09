// 🔧 Overlay DSL System Refactored to Unified `context.overlay` API

import 'package:flutter/material.dart';
import '../errors_handling/failures/extensions/_failure_x_imports.dart';
import '../errors_handling/failures/failure_ui_model.dart';
import 'core/overlay_dispatcher.dart';
import 'core/overlay_message_key.dart';
import 'core/overlay_requests.dart';
import 'core/overlay_kind.dart';
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
        ),
      ),
    );
  }

  void loader({
    required Widget child,
    Duration duration = const Duration(seconds: 2),
  }) => _context._showOverlayRequest(LoaderOverlay(child, duration: duration));

  void showBanner({required OverlayKind kind, required String message}) {
    final key = StaticOverlayMessageKey(
      'overlay.kind.${kind.runtimeType}',
      fallback: message,
    );
    _context._showOverlayRequest(
      BannerOverlay(
        AnimatedKindBanner(message: message, kind: kind),
        duration: const Duration(seconds: 2),
        messageKey: key,
      ),
    );
  }

  void showBannerWidget(
    Widget banner, {
    Duration duration = const Duration(seconds: 2),
  }) => _context._showOverlayRequest(BannerOverlay(banner, duration: duration));

  void themeBanner({required OverlayMessageKey key, required IconData icon}) =>
      _context._showOverlayRequest(
        ThemedBannerOverlay(key.localize(_context), icon, messageKey: key),
      );

  ///
  void showRequest(OverlayAction request) {
    _context._showOverlayRequest(request);
  }

  ///
}

// 🧩 [OverlayDSL Extension] — Add method to show error via FailureUIModel
extension OverlayShowFailureX on OverlayController {
  void showError(FailureUIModel model) {
    final key =
        model.translationKey == null
            ? null
            : StaticOverlayMessageKey(
              model.translationKey!,
              fallback: model.fallbackMessage,
            );

    switch (model.presentation) {
      case FailurePresentationType.banner:
        showBanner(kind: model.kind, message: model.fallbackMessage);
        break;
      case FailurePresentationType.snackbar:
        snackbar(model.fallbackMessage);
        break;
      case FailurePresentationType.dialog:
        dialog(
          title: 'Error',
          content: key?.localize(_context) ?? model.fallbackMessage,
        );
        break;
    }
  }
}
