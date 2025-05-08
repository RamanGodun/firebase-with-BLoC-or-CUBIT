import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/_failure_x_imports.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlay/_overlay_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlay/requests.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import '../failures/failure.dart';
import 'consumable.dart';

/// 📌 [FailureNotifier] — Centralized one-shot UI handler for [Failure].
/// ✅ Works with [Consumable<Failure>] to prevent duplicate feedback.
/// ✅ Supports both dialogs and banner overlays based on failure type.
//----------------------------------------------------------------
final class FailureNotifier {
  /// 🧩 Shows feedback for [Consumable<Failure>] and resets state after delay.
  static void handleAndReset(
    BuildContext context,
    Consumable<Failure>? consumable, {
    required VoidCallback onReset,
  }) {
    final failure = consumable?.consume();
    if (failure != null) {
      _show(context, failure);
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) return;
        onReset();
      });
    }
  }

  /// 🧩 Shows feedback for [Consumable<Failure>] without state mutation.
  static void handle(BuildContext context, Consumable<Failure>? consumable) {
    final failure = consumable?.consume();
    if (failure != null) _show(context, failure);
  }

  /// 📍 Shows platform dialog regardless of failure type (critical fallback).
  static void showDialog(BuildContext context, Failure failure) {
    final key = failure.toOverlayMessageKey();

    context.showOverlayRequest(
      DialogRequest(
        AlertDialog(
          title: const TextWidget('Error', TextType.titleLarge),
          content: TextWidget(
            key?.localize(context) ?? failure.message,
            TextType.error,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const TextWidget('OK', TextType.titleMedium),
            ),
          ],
        ),
      ),
    );
  }

  /// 🔁 Internal logic: decide which overlay to show
  static void _show(BuildContext context, Failure failure) {
    context.unfocusKeyboard();

    if (failure.isNetworkFailure || failure.isFirebaseFailure) {
      context.showOverlayRequest(failure.overlayThemeBanner(context));
    } else {
      showDialog(context, failure);
    }
  }
}
