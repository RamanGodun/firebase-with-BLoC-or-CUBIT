import 'package:flutter/material.dart';

/// Типи оверлеїв для DSL-подібного API
//-------------------------------------------------------------
enum OverlayType { snackbar, dialog, banner, loading, widget }

/// 🎯 Base sealed class for overlay requests
//-------------------------------------------------------------
sealed class OverlayRequest {
  const OverlayRequest();

  Duration get duration;
}

final class DialogRequest extends OverlayRequest {
  final Widget dialog;
  const DialogRequest(this.dialog);

  @override
  Duration get duration => Duration.zero;
}

final class SnackbarRequest extends OverlayRequest {
  final SnackBar snackbar;
  const SnackbarRequest(this.snackbar);

  /// Альтернативна фабрика без дублювання `SnackBar(...)`
  factory SnackbarRequest.from(String message) =>
      SnackbarRequest(SnackBar(content: Text(message)));

  @override
  Duration get duration => const Duration(seconds: 2);
}

final class BannerRequest extends OverlayRequest {
  final Widget banner;
  @override
  final Duration duration;

  const BannerRequest(
    this.banner, {
    this.duration = const Duration(seconds: 2),
  });
}

final class LoaderRequest extends OverlayRequest {
  final Widget loader;
  @override
  final Duration duration;

  const LoaderRequest(
    this.loader, {
    this.duration = const Duration(seconds: 2),
  });
}

final class WidgetRequest extends OverlayRequest {
  final Widget widget;
  @override
  final Duration duration;

  const WidgetRequest(
    this.widget, {
    this.duration = const Duration(seconds: 2),
  });
}
