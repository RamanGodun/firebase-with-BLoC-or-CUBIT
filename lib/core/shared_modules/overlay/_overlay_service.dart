import 'dart:async';
import 'package:flutter/material.dart';
import 'overlay_widget.dart';

/// 🌟 [OverlayNotificationService] — macOS-style floating banner overlay
/// ✅ Displays temporary overlay notifications
//-------------------------------------------------------------

@pragma('vm:entry-point')
abstract final class OverlayNotificationService {
  OverlayNotificationService._();

  /// 📍 Holds the currently visible overlay (if any)
  static OverlayEntry? _activeOverlay;
  // 🕒 Timer to auto-dismiss overlay after delay
  static Timer? _debounceTimer;

  /// 📢 Show a temporary floating overlay banner
  /// 🧼 Replaces any existing overlay before showing new one
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

  /// ✅ Show success overlay with default green check icon
  static void showSuccess(BuildContext context, String message) =>
      showOverlay(context, message: message, icon: Icons.check_circle_rounded);

  /// ❌ Show error overlay with default red error icon
  static void showError(BuildContext context, String message) =>
      showOverlay(context, message: message, icon: Icons.error_outline_rounded);

  /// 🧽 Manually dismiss overlay (if visible)
  static void dismissIfVisible() => _removeOverlay();

  /// 🔧 Removes active overlay entry
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
  dismissKeyboard: false, // if need to leave focus
);


 */