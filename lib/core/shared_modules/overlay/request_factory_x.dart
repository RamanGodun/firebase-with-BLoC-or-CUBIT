import 'package:flutter/material.dart';
import 'requests.dart';

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
