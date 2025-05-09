import 'package:flutter/material.dart';

import 'overlay_message_key.dart';

/// 🎯 Base sealed class for overlay requests
sealed class OverlayAction {
  const OverlayAction();

  Duration get duration;
  OverlayMessageKey? get messageKey => null;
}

/// 💬 Platform adaptive dialog
final class DialogOverlay extends OverlayAction {
  final Widget dialog;
  const DialogOverlay(this.dialog);

  @override
  Duration get duration => Duration.zero;
}

/// 🍞 Snackbar overlay with optional localization key
final class SnackbarOverlay extends OverlayAction {
  final SnackBar snackbar;
  @override
  final OverlayMessageKey? messageKey;

  const SnackbarOverlay(this.snackbar, {this.messageKey});

  factory SnackbarOverlay.from(String message, {OverlayMessageKey? key}) =>
      SnackbarOverlay(SnackBar(content: Text(message)), messageKey: key);

  @override
  Duration get duration => const Duration(seconds: 2);
}

/// 🪧 Banner overlay
final class BannerOverlay extends OverlayAction {
  final Widget banner;
  @override
  final Duration duration;

  @override
  final OverlayMessageKey? messageKey;

  const BannerOverlay(
    this.banner, {
    this.duration = const Duration(seconds: 2),
    this.messageKey,
  });
}

/// ⏳ Loading indicator overlay
final class LoaderOverlay extends OverlayAction {
  final Widget loader;
  @override
  final Duration duration;

  const LoaderOverlay(
    this.loader, {
    this.duration = const Duration(seconds: 2),
  });
}

/// 🧩 Custom widget overlay
final class CustomOverlay extends OverlayAction {
  final Widget widget;
  @override
  final Duration duration;

  const CustomOverlay(
    this.widget, {
    this.duration = const Duration(seconds: 2),
  });
}

///
final class ThemedBannerOverlay extends OverlayAction {
  final String message;
  final IconData icon;

  @override
  final OverlayMessageKey? messageKey;

  const ThemedBannerOverlay(this.message, this.icon, {this.messageKey});

  @override
  Duration get duration => const Duration(seconds: 2);
}
