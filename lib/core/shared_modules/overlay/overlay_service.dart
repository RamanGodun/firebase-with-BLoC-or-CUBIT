import 'dart:async';
import 'package:flutter/material.dart';
import '_overlay_dispatcher.dart';
import '_overlay_message_key.dart';
import '_overlay_request.dart';
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

  ///
  ///

  /// ✅ Show localized error overlay
  static void showError(BuildContext context, OverlayMessageKey key) =>
      _showLocalizedSnackbar(context, key, type: _OverlayType.error);

  /// ✅ Show localized success overlay
  static void showSuccess(BuildContext context, OverlayMessageKey key) =>
      _showLocalizedSnackbar(context, key, type: _OverlayType.success);

  /// ✅ Show localized info overlay
  static void showInfo(BuildContext context, OverlayMessageKey key) =>
      _showLocalizedSnackbar(context, key, type: _OverlayType.info);

  /// ✅ Show raw snackbar
  static void showRawSnackbar(BuildContext context, String message) =>
      OverlayDispatcher.instance.enqueueRequest(
        context,
        SnackbarRequest.from(message),
      );

  /// ✅ Show adaptive dialog
  static void showDialogBox(BuildContext context, Widget dialog) =>
      OverlayDispatcher.instance.enqueueRequest(context, DialogRequest(dialog));

  /// ✅ Show loading indicator
  static void showLoading(BuildContext context, Widget loader) =>
      OverlayDispatcher.instance.enqueueRequest(context, LoaderRequest(loader));

  /// ✅ Show custom widget overlay
  static void showCustomWidget(BuildContext context, Widget widget) =>
      OverlayDispatcher.instance.enqueueRequest(context, WidgetRequest(widget));

  /// 🧼 Clear all overlays in queue
  static void clearAll() => OverlayDispatcher.instance.clearAll();

  /// 🧼 Clear overlays for given context
  static void clearForContext(BuildContext context) =>
      OverlayDispatcher.instance.clearByContext(context);

  /// 🧩 Localized helper method
  static void _showLocalizedSnackbar(
    BuildContext context,
    OverlayMessageKey key, {
    required _OverlayType type,
  }) {
    final message = key.localize(context);
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: _colorForType(type),
    );
    OverlayDispatcher.instance.enqueueRequest(
      context,
      SnackbarRequest(snackBar, messageKey: key),
    );
  }

  static Color _colorForType(_OverlayType type) => switch (type) {
    _OverlayType.error => Colors.redAccent,
    _OverlayType.success => Colors.green,
    _OverlayType.info => Colors.blueAccent,
  };

  ///
}

///
/// 🧩 Internal semantic overlay type
enum _OverlayType { error, success, info }
