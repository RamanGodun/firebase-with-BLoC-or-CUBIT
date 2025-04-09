import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../presentation/widgets/text_widget.dart';
import '../../constants/app_constants.dart';

part 'overlay_widget.dart';

/// 🌟 **[OverlayNotificationService]** – Displays animated overlay messages in macOS/iOS style.
class OverlayNotificationService {
  static OverlayEntry? _overlayEntry;

  /// 📌 **Show Overlay Notification**
  /// Displays an animated overlay message with an [icon] and [message].
  /// If a global loader is active, the overlay is not shown.
  static void showOverlay(
    BuildContext context, {
    required String message,
    required IconData icon,
  }) {
    _removeOverlay();

    final overlay = Overlay.of(context, rootOverlay: true);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => _AnimatedOverlayWidget(message: message, icon: icon),
    );

    overlay.insert(_overlayEntry!);
    Future.delayed(const Duration(seconds: 2), () => _removeOverlay());
  }

  /// 🛑 **Remove Overlay**
  /// Closes and removes the overlay from the screen.
  static void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
