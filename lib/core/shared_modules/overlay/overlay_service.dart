import 'dart:async';
import 'package:flutter/material.dart';
import 'custom_animated_banner/overlay_widget.dart';

/// 🌟 [OverlayNotificationService] — macOS-style + adaptive overlay system
/// ✅ Displays snackbars, dialogs, alert dialogs, custom banners
//-------------------------------------------------------------

@pragma('vm:entry-point')
abstract final class OverlayNotificationService {
  OverlayNotificationService._();

  /// 📍 Holds the currently visible overlay (if any)
  static OverlayEntry? _activeOverlay;

  /// 🕒 Timer to auto-dismiss overlay after delay
  static Timer? _debounceTimer;

  // === 🔁 BACKWARD-COMPATIBILITY ===

  /// 📢 Show a temporary floating overlay banner
  static void showOverlay(
    BuildContext context, {
    required String message,
    required IconData icon,
    bool dismissKeyboard = true,
  }) {
    _debounceTimer?.cancel();
    _removeOverlay();
    if (dismissKeyboard) FocusScope.of(context).unfocus();
    final overlay = Overlay.of(context, rootOverlay: true);
    _activeOverlay = OverlayEntry(
      builder: (_) => AnimatedOverlayWidget(message: message, icon: icon),
    );
    overlay.insert(_activeOverlay!);
    _debounceTimer = Timer(const Duration(seconds: 2), _removeOverlay);
  }

  /// 🧽 Manually dismiss overlay (if visible)
  static void dismissIfVisible() => _removeOverlay();

  /// 🔧 Removes active overlay entry
  static void _removeOverlay() {
    if (_activeOverlay?.mounted ?? false) {
      _activeOverlay?.remove();
    }
    _activeOverlay = null;
  }
}
