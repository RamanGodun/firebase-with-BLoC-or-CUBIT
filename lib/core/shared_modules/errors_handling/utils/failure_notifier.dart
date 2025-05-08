import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/_failure_x_imports.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlay/_overlay_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../overlay/overlay_message_key.dart';
import '../../overlay/requests.dart';
import '../failures/_failure.dart';
import 'consumable.dart';

/// 📌 [FailureNotifier] — Centralized one-shot UI handler for [Failure].
/// ✅ Works with [Consumable<Failure>] to prevent duplicate feedback.
/// ✅ Supports both dialogs and banner overlays based on failure type.
//----------------------------------------------------------------
final class FailureNotifier {
  /// 🧩 Shows UI feedback for [Consumable<Failure>] and resets state after delay.
  /// ✅ Ensures error is only shown once (via `.consume()`).
  /// ✅ Executes optional `onReset()` after 300ms (e.g. for Bloc reset).
  static void handleAndReset(
    BuildContext context,
    Consumable<Failure>? consumable, {
    required VoidCallback onReset,
  }) {
    final failure = consumable?.consume();
    if (failure != null) {
      context.unfocusKeyboard();
      _showFeedback(context, failure);

      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) return;
        onReset();
      });
    }
  }

  /// 🧩 Shows UI feedback for [Consumable<Failure>] without any reset logic.
  /// ✅ Use when no Bloc/form state mutation is needed after error.
  static void handle(BuildContext context, Consumable<Failure>? consumable) {
    final failure = consumable?.consume();
    if (failure != null) {
      context.unfocusKeyboard();
      _showFeedback(context, failure);
    }
  }

  /// 🔁 Internal feedback logic: Banner for known UX-friendly cases, Dialog for others
  static void _showFeedback(BuildContext context, Failure failure) {
    final key = failure.translationKey;
    final fallback = failure.message;

    // ✨ Show UX-friendly overlay if defined
    if (failure.isNetworkFailure || failure.isFirebaseFailure) {
      context.showOverlayRequest(
        SnackbarRequest(
          SnackBar(content: Text(failure.uiMessage(context))),
          messageKey:
              key != null
                  ? StaticOverlayMessageKey(key, fallback: fallback)
                  : null,
        ),
      );
      return;
    }

    // 📍 Fallback to platform dialog
    context.showOverlayRequest(
      DialogRequest(
        AlertDialog(
          title: const Text('Error'),
          content: Text(failure.uiMessage(context)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
