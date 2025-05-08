import 'package:flutter/material.dart';
import 'dispatcher.dart';
import 'requests.dart';

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

  void showPlatformDialog(Widget dialog) =>
      showOverlayRequest(DialogRequest(dialog));

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

  void showThemeBanner({required String message, required IconData icon}) =>
      showOverlayRequest(ThemeBannerRequest(message, icon));

  //=============================================================
  // 🧩 VARIANT 2: DSL-like API (switch-based)
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
        throw ArgumentError('Missing required fields for overlay type: $type'),
    };
    showOverlayRequest(request);
  }

  ///
}

/// 🧩 DSL enum types for overlay rendering
enum OverlayType { snackbar, dialog, banner, loading, widget }

/*
context.showSnackbar('Saved!');
context.showPlatformDialog(AlertDialog(...));
context.showBannerOverlay(MyBanner());
 */

/*
context.showOverlay(OverlayType.snackbar, message: 'Welcome!');
context.showOverlay(OverlayType.dialog, child: AlertDialog(...));
context.showOverlay(OverlayType.banner, child: MyBanner());
 */
