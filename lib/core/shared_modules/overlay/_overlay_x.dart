import 'package:flutter/material.dart';
import '_overlay_dispatcher.dart';
import '_overlay_request.dart';

/// 🧩 Syntactic sugar for overlay system
extension OverlayExtensions on BuildContext {
  //

  ///
  void showOverlayRequest(OverlayRequest request) =>
      OverlayDispatcher.instance.enqueueRequest(this, request);

  //
  /// ✅ Лаконічні виклики без дублювання типів (варіант 1)
  //-------------------------------------------------------------

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
  /*
context.showSnackbar('Saved!');
context.showPlatformDialog(AlertDialog(...));
context.showBannerOverlay(MyBanner());
 */

  //=============================================================

  //
  /// 🧩 DSL-подібний API (варіант 2)
  //-------------------------------------------------------------

  void showOverlay(
    OverlayType type, {
    String? message,
    Widget? child,
    Duration duration = const Duration(seconds: 2),
  }) {
    final request = switch (type) {
      OverlayType.snackbar => SnackbarRequest.from(message!),
      OverlayType.dialog => DialogRequest(child!),
      OverlayType.banner => BannerRequest(child!, duration: duration),
      OverlayType.loading => LoaderRequest(child!, duration: duration),
      OverlayType.widget => WidgetRequest(child!, duration: duration),
    };
    showOverlayRequest(request);
  }
  /*
context.showOverlay(OverlayType.snackbar, message: 'Welcome!');
context.showOverlay(OverlayType.dialog, child: AlertDialog(...));
context.showOverlay(OverlayType.banner, child: MyBanner());
 */

  ///
}

/// 🧪 Допоміжні фабрики (опційно)
/// Типи оверлеїв для DSL-подібного API
//-------------------------------------------------------------

extension OverlayRequestFactories on Object {
  SnackbarRequest overlaySnackbar(String message) =>
      SnackbarRequest.from(message);

  DialogRequest overlayDialog(Widget dialog) => DialogRequest(dialog);

  BannerRequest overlayBanner(
    Widget banner, {
    Duration duration = const Duration(seconds: 2),
  }) => BannerRequest(banner, duration: duration);

  LoaderRequest overlayLoader(
    Widget loader, {
    Duration duration = const Duration(seconds: 2),
  }) => LoaderRequest(loader, duration: duration);

  WidgetRequest overlayWidget(
    Widget widget, {
    Duration duration = const Duration(seconds: 2),
  }) => WidgetRequest(widget, duration: duration);
}

enum OverlayType { snackbar, dialog, banner, loading, widget }
