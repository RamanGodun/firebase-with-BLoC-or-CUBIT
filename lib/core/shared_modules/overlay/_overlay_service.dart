import 'dart:async';
import 'package:flutter/material.dart';
import 'overlay_widget.dart';

/// 🌟 [OverlayNotificationService] — macOS-style overlay banner
class OverlayNotificationService {
  static OverlayEntry? _activeOverlay;
  static Timer? _debounceTimer;

  /// 📌 Displays a styled toast-like overlay
  static void showOverlay(
    BuildContext context, {
    required String message,
    required IconData icon,
    bool dismissKeyboard = true,
  }) {
    _debounceTimer?.cancel();
    _removeOverlay();

    if (dismissKeyboard) {
      FocusScope.of(context).unfocus();
    }

    final overlay = Overlay.of(context, rootOverlay: true);

    _activeOverlay = OverlayEntry(
      builder: (_) => AnimatedOverlayWidget(message: message, icon: icon),
    );

    overlay.insert(_activeOverlay!);
    _debounceTimer = Timer(const Duration(seconds: 2), _removeOverlay);
  }

  static void showSuccess(BuildContext context, String message) =>
      showOverlay(context, message: message, icon: Icons.check_circle_rounded);

  static void showError(BuildContext context, String message) =>
      showOverlay(context, message: message, icon: Icons.error_outline_rounded);

  static void dismissIfVisible() => _removeOverlay();

  static void _removeOverlay() {
    if (_activeOverlay?.mounted ?? false) {
      _activeOverlay?.remove();
    }
    _activeOverlay = null;
  }

  ///
}


/*
! Call looks like this

OverlayNotificationService.showSuccess(context, 'Done!');

? or

OverlayNotificationService.showSuccess(
  context,
  'Saved!',
  dismissKeyboard: false, // якщо треба залишити фокус
);


 */