import 'package:flutter/material.dart';

import 'overlay_message_key.dart';

/// 🎯 Base sealed class for overlay requests
sealed class OverlayRequest {
  const OverlayRequest();

  Duration get duration;
  OverlayMessageKey? get messageKey => null;
}

/// 💬 Platform adaptive dialog
final class DialogRequest extends OverlayRequest {
  final Widget dialog;
  const DialogRequest(this.dialog);

  @override
  Duration get duration => Duration.zero;
}

/// 🍞 Snackbar overlay with optional localization key
final class SnackbarRequest extends OverlayRequest {
  final SnackBar snackbar;
  @override
  final OverlayMessageKey? messageKey;

  const SnackbarRequest(this.snackbar, {this.messageKey});

  factory SnackbarRequest.from(String message, {OverlayMessageKey? key}) =>
      SnackbarRequest(SnackBar(content: Text(message)), messageKey: key);

  @override
  Duration get duration => const Duration(seconds: 2);
}

/// 🪧 Banner overlay
final class BannerRequest extends OverlayRequest {
  final Widget banner;
  @override
  final Duration duration;

  @override
  final OverlayMessageKey? messageKey;

  const BannerRequest(
    this.banner, {
    this.duration = const Duration(seconds: 2),
    this.messageKey,
  });
}

/// ⏳ Loading indicator overlay
final class LoaderRequest extends OverlayRequest {
  final Widget loader;
  @override
  final Duration duration;

  const LoaderRequest(
    this.loader, {
    this.duration = const Duration(seconds: 2),
  });
}

/// 🧩 Custom widget overlay
final class WidgetRequest extends OverlayRequest {
  final Widget widget;
  @override
  final Duration duration;

  const WidgetRequest(
    this.widget, {
    this.duration = const Duration(seconds: 2),
  });
}

///
final class ThemeBannerRequest extends OverlayRequest {
  final String message;
  final IconData icon;

  @override
  final OverlayMessageKey? messageKey;

  const ThemeBannerRequest(this.message, this.icon, {this.messageKey});

  @override
  Duration get duration => const Duration(seconds: 2);
}
