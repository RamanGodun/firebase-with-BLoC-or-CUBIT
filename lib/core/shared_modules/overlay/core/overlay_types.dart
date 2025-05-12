import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/text_widget.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';

import '../../../constants/_app_constants.dart';
import 'overlay_presets.dart';
import 'overlay_message_key.dart';

/// 🎯 [OverlayUIEntry] — Base sealed class for all queued overlay UI entries
/// ✅ Used to distinguish between Snackbar, Banner, Dialog, etc.
sealed class OverlayUIEntry {
  const OverlayUIEntry();

  Duration get duration;
  OverlayMessageKey? get messageKey => null;
}

/// 💬 [DialogOverlayEntry] — Represents a platform-adaptive dialog overlay
final class DialogOverlayEntry extends OverlayUIEntry {
  final Widget dialog;
  const DialogOverlayEntry(this.dialog);

  @override
  Duration get duration => Duration.zero;
}

/// 🍞 [SnackbarOverlayEntry] — Represents a styled snackbar overlay
final class SnackbarOverlayEntry extends OverlayUIEntry {
  final SnackBar snackbar;
  @override
  final OverlayMessageKey? messageKey;
  const SnackbarOverlayEntry(this.snackbar, {this.messageKey});

  /// 🏗️ Factory with support for presets, localization keys and custom icon
  factory SnackbarOverlayEntry.from(
    String message, {
    BuildContext? context,
    OverlayMessageKey? key,
    OverlayUIPresets preset = const OverlayErrorPreset(),
    IconData? icon,
  }) {
    final resolvedColor = context?.colorScheme.onPrimary ?? AppColors.white;
    return SnackbarOverlayEntry(
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
          left: true,
          right: true,
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

/// 🪧 [BannerOverlayEntry] — Represents a banner overlay (animated or custom)
final class BannerOverlayEntry extends OverlayUIEntry {
  final Widget banner;
  @override
  final Duration duration;
  @override
  final OverlayMessageKey? messageKey;

  const BannerOverlayEntry(
    this.banner, {
    this.duration = const Duration(seconds: 2),
    this.messageKey,
  });
}

/// ⏳ [LoaderOverlayEntry] — Represents a loading spinner overlay
final class LoaderOverlayEntry extends OverlayUIEntry {
  final Widget loader;
  @override
  final Duration duration;

  const LoaderOverlayEntry(
    this.loader, {
    this.duration = const Duration(seconds: 2),
  });
}

/// 🧩 [CustomOverlayEntry] — Generic overlay with any widget and duration
final class CustomOverlayEntry extends OverlayUIEntry {
  final Widget widget;
  @override
  final Duration duration;

  const CustomOverlayEntry(
    this.widget, {
    this.duration = const Duration(seconds: 2),
  });
}

/// 🎨 [ThemedBannerOverlayEntry] — Predefined banner with icon and message, styled by theme
final class ThemedBannerOverlayEntry extends OverlayUIEntry {
  final String message;
  final IconData icon;

  @override
  final OverlayMessageKey? messageKey;

  const ThemedBannerOverlayEntry(this.message, this.icon, {this.messageKey});

  @override
  Duration get duration => const Duration(seconds: 2);
}
