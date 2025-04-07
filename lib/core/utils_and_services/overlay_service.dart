import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../presentation/widgets/text_widget.dart';
import '../constants/app_constants.dart';


/// 🌟 **[OverlayNotificationService]** – Displays animated overlay messages in macOS/iOS style.
class OverlayNotificationService {
  static OverlayEntry? _overlayEntry;

  /// 📌 **Show Overlay Notification**
  /// Displays an animated overlay message with an [icon] and [message].
  /// If a global loader is active, the overlay is not shown.
  static void showOverlay(BuildContext context,
      {required String message, required IconData icon}) {
    _removeOverlay();

    final overlay = Overlay.of(context, rootOverlay: true);

    _overlayEntry = OverlayEntry(
      builder: (context) =>
          _AnimatedOverlayWidget(message: message, icon: icon),
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

/// 🎭 **_AnimatedOverlayWidget** - Beautiful animated notification widget.
class _AnimatedOverlayWidget extends HookWidget {
  final String message;
  final IconData icon;

  const _AnimatedOverlayWidget({required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    )..forward();

    final opacity = animationController.drive(
      Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeOut)),
    );

    final scale = animationController.drive(
      Tween<double>(begin: 0.8, end: 1)
          .chain(CurveTween(curve: Curves.elasticOut)),
    );

    // 🎨 **Get theme-aware colors dynamically**
    final colorScheme = Helpers.getColorScheme(context);
    final isDarkMode = colorScheme.brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? AppConstants.overlayDarkBackground
        : AppConstants.overlayLightBackground;
    final textColor = isDarkMode
        ? AppConstants.overlayDarkTextColor
        : AppConstants.overlayLightTextColor;
    final borderColor = isDarkMode
        ? AppConstants.overlayDarkBorder
        : AppConstants.overlayLightBorder;
    final shadowColor = Colors.black.withOpacity(0.3);

    return Stack(
      children: [
        Positioned(
          // 🔽 Centers the overlay message on the screen
          top: MediaQuery.of(context).size.height * 0.4,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          child: FadeTransition(
            opacity: opacity,
            child: ScaleTransition(
              scale: scale,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: shadowColor,
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: textColor, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextWidget(message, TextType.titleMedium),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
