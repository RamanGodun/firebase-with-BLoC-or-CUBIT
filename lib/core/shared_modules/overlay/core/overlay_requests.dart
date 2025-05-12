import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/text_widget.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';

import '../../../constants/_app_constants.dart';
import 'overlay_presets.dart';
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

  factory SnackbarOverlay.from(
    String message, {
    BuildContext? context,
    OverlayMessageKey? key,
    OverlayPresets preset = const OverlayErrorPreset(),
    IconData? icon,
  }) {
    ///
    final resolvedColor = context?.colorScheme.onPrimary ?? AppColors.white;
    //
    return SnackbarOverlay(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
        padding: preset.contentPadding,
        shape: preset.shape,
        duration: preset.duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SafeArea(
          top: true,
          bottom: false,
          left: false,
          right: false,
          child: Container(
            decoration: BoxDecoration(
              color: preset.color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon ?? preset.icon,
                  color: preset.color,
                ).withPaddingLeft(10),
                const SizedBox(width: 6),
                Expanded(
                  child: TextWidget(
                    message,
                    TextType.error,
                    color: resolvedColor,
                    isTextOnFewStrings: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      messageKey: key,
    );
  }

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
