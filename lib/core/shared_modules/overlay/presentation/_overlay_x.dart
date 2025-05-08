import 'package:flutter/material.dart';
import 'widgets/animated_kind_banner.dart';
import '../core/overlay_dispatcher.dart';
import 'overlay_kind.dart';
import '../core/overlay_message_key.dart';
import 'widgets/platform_dialog_widget.dart';
import '../core/overlay_requests.dart';

/// 🧩 Syntactic sugar for overlay system
extension OverlayExtensions on BuildContext {
  /// 🔁 Enqueue raw overlay request
  void showOverlayRequest(OverlayRequest request) =>
      OverlayDispatcher.instance.enqueueRequest(this, request);

  //=============================================================
  // ✅ VARIANT 1: Concise API (no type repetition)
  //=============================================================

  void showSnackbar(String message) =>
      showOverlayRequest(SnackbarRequest.from(message));

  void showPlatformDialogText({
    required String title,
    required String content,
    String confirmText = 'OK',
    String cancelText = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
  }) => showOverlayRequest(
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

  void showCustomOverlay(
    Widget widget, {
    Duration duration = const Duration(seconds: 2),
  }) => showOverlayRequest(WidgetRequest(widget, duration: duration));

  void showBannerOverlay(
    Widget banner, {
    Duration duration = const Duration(seconds: 2),
  }) => showOverlayRequest(BannerRequest(banner, duration: duration));

  void showLoaderOverlay(
    Widget loader, {
    Duration duration = const Duration(seconds: 2),
  }) => showOverlayRequest(LoaderRequest(loader, duration: duration));

  void showThemeBanner({
    required OverlayMessageKey key,
    required IconData icon,
  }) {
    showOverlayRequest(
      ThemeBannerRequest(key.localize(this), icon, messageKey: key),
    );
  }

  //=============================================================
  // ✅ VARIANT 2: Semantically grouped overlays (Kind-based)
  //=============================================================

  void showErrorBanner(OverlayMessageKey key) =>
      _showKindBanner(key, OverlayKind.error);

  void showSuccessBanner(OverlayMessageKey key) =>
      _showKindBanner(key, OverlayKind.success);

  void showInfoBanner(OverlayMessageKey key) =>
      _showKindBanner(key, OverlayKind.info);

  void showWarningBanner(OverlayMessageKey key) =>
      _showKindBanner(key, OverlayKind.warning);

  void showConfirmBanner(OverlayMessageKey key) =>
      _showKindBanner(key, OverlayKind.confirm);

  void _showKindBanner(OverlayMessageKey key, OverlayKind kind) =>
      showOverlayRequest(
        BannerRequest(
          AnimatedKindBanner(message: key.localize(this), kind: kind),
          duration: const Duration(seconds: 2),
          messageKey: key,
        ),
      );

  //=============================================================
  // 🧩 VARIANT 3: DSL-like API (switch-based)
  //=============================================================

  void showOverlay(
    OverlayType type, {
    String? message,
    Widget? child,
    Duration duration = const Duration(seconds: 2),
  }) {
    final request = switch (type) {
      OverlayType.snackbar when message != null => SnackbarRequest.from(
        message,
      ),
      OverlayType.dialog when child != null => DialogRequest(child),
      OverlayType.banner when child != null => BannerRequest(
        child,
        duration: duration,
      ),
      OverlayType.loading when child != null => LoaderRequest(
        child,
        duration: duration,
      ),
      OverlayType.widget when child != null => WidgetRequest(
        child,
        duration: duration,
      ),
      _ =>
        throw ArgumentError('Missing required fields for overlay type: \$type'),
    };
    showOverlayRequest(request);
  }

  ///
}

/// 🧩 DSL enum types for overlay rendering
enum OverlayType { snackbar, dialog, banner, loading, widget }
