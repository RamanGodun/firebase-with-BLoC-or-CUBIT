import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/text_widget.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';

import '../../../constants/_app_constants.dart';
import '../overlay_presets/overlay_presets.dart';
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
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final IconData? icon;
  final Color? color;

  const DialogOverlayEntry({
    required this.title,
    required this.content,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.color,
  });

  Widget build() => AlertDialog(
    title: Row(
      children: [
        if (icon != null) Icon(icon, size: 24),
        if (icon != null) const SizedBox(width: 8),
        Text(title),
      ],
    ),
    content: Text(content),
    actions: [
      TextButton(
        onPressed: () {
          onCancel?.call();
          // Navigator pop will be done by dispatcher
        },
        child: Text(cancelText),
      ),
      TextButton(
        onPressed: () {
          onConfirm?.call();
          // Navigator pop will be done by dispatcher
        },
        child: Text(confirmText),
      ),
    ],
  );

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
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
    IconData? icon,
  }) {
    final resolvedColor = context?.colorScheme.onPrimary ?? AppColors.white;
    final props = preset.resolve();
    return SnackbarOverlayEntry(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
        padding: props.contentPadding,
        shape: props.shape,
        duration: props.duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SafeArea(
          top: true,
          bottom: false,
          left: true,
          right: true,
          child: Container(
            decoration: BoxDecoration(
              color: props.color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon ?? props.icon,
                  color: props.color,
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

