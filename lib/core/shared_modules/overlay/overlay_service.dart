import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'overlay_widget.dart';

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

  // === 🆕 ADAPTIVE SYSTEM ===

  static Future<void> show(
    BuildContext context, {
    required OverlayType type,
    required String message,
    IconData? icon,
    Duration duration = const Duration(seconds: 2),
  }) async {
    switch (type) {
      case OverlayType.customOverlay:
        showOverlay(context, message: message, icon: icon ?? Icons.info);
        break;

      case OverlayType.snackbar:
        _showMaterialSnackbar(context, message);
        break;

      case OverlayType.dialog:
        await _showPlatformDialog(context, message);
        break;

      case OverlayType.alertDialog:
        await _showPlatformAlertDialog(context, message);
        break;
    }
  }

  static void _showMaterialSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  static Future<void> _showPlatformDialog(
    BuildContext context,
    String message,
  ) async {
    if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        builder:
            (_) => CupertinoAlertDialog(
              title: const Text('Info'),
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
    } else {
      await showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Info'),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
    }
  }

  static Future<void> _showPlatformAlertDialog(
    BuildContext context,
    String message,
  ) async {
    if (Platform.isIOS) {
      await showCupertinoDialog(
        context: context,
        builder:
            (_) => CupertinoAlertDialog(
              title: const Text('Error'),
              content: Text(message),
              actions: [
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
    } else {
      await showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: const Text('Error'),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
      );
    }
  }
}

/// 🧩 [OverlayType] — Declarative way to show various notification UIs
enum OverlayType {
  customOverlay, // 🎭 Banner with animation
  snackbar, // 📢 Material snackbar
  dialog, // 💬 Info dialog
  alertDialog, // ❗ Critical error dialog
}
