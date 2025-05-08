import 'package:flutter/material.dart';
import 'core/overlay_dispatcher.dart';
import 'core/overlay_message_key.dart';
import 'core/overlay_requests.dart';
import 'core/overlay_kind.dart';
import 'presentation/widgets/animated_kind_banner.dart';
import 'presentation/widgets/platform_dialog_widget.dart';

/// ✅ Main extension for accessing overlay DSL
extension OverlayDSL on BuildContext {
  OverlayController get overlay => OverlayController(this);
}

/// 🛡️ Private extension — інкапсулює raw dispatcher call
extension _OverlayDispatcherX on BuildContext {
  void _showOverlayRequest(OverlayRequest request) {
    OverlayDispatcher.instance.enqueueRequest(this, request);
  }
}

/// 🎛️ Main controller class for overlay categories
final class OverlayController {
  final BuildContext _context;
  const OverlayController(this._context);

  void snackbar(String message) =>
      _context._showOverlayRequest(SnackbarRequest.from(message));

  void dialog({
    required String title,
    required String content,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) {
    _context._showOverlayRequest(
      DialogRequest(
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
  }) => _context._showOverlayRequest(LoaderRequest(child, duration: duration));

  OverlayBannerController get banner => OverlayBannerController(_context);

  void themeBanner({required OverlayMessageKey key, required IconData icon}) {
    _context._showOverlayRequest(
      ThemeBannerRequest(key.localize(_context), icon, messageKey: key),
    );
  }
}

/// 🪧 Banner controller for kind-driven overlays
final class OverlayBannerController {
  final BuildContext _context;
  const OverlayBannerController(this._context);

  void success(String message) => _show(message, OverlayKind.success);
  void error(String message) => _show(message, OverlayKind.error);
  void info(String message) => _show(message, OverlayKind.info);
  void warning(String message) => _show(message, OverlayKind.warning);
  void confirm(String message) => _show(message, OverlayKind.confirm);

  void _show(String message, OverlayKind kind) {
    final key = StaticOverlayMessageKey(
      'overlay.kind.${kind.runtimeType}',
      fallback: message,
    );
    _context._showOverlayRequest(
      BannerRequest(
        AnimatedKindBanner(message: message, kind: kind),
        duration: const Duration(seconds: 2),
        messageKey: key,
      ),
    );
  }
}
