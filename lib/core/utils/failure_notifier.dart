import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../shared_modules/errors_handling/failures/_failure.dart';
import '../shared_modules/overlay/_overlay_service.dart';
import 'consumable.dart';

/// 📌 [FailureNotifier] — Centralized one-shot UI handler for [Failure].
/// ✅ Works with [Consumable<Failure>] to prevent duplicate feedback.
/// ✅ Used for overlay dialogs or toast-based error messages.
//----------------------------------------------------------------

final class FailureNotifier {
  //
  /// 🧩 Shows dialog for [Consumable<Failure>] and resets state after delay.
  /// ✅ Ensures error is only shown once (via `.consume()`).
  /// ✅ Executes optional `onReset()` after 300ms (e.g. for Bloc reset).
  static void handleAndReset(
    BuildContext context,
    Consumable<Failure>? consumable, {
    required VoidCallback onReset,
  }) {
    final failure = consumable?.consume();
    if (failure != null) {
      OverlayNotificationService.dismissIfVisible();
      context.showFailureDialog(failure);

      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) return;
        onReset();
      });
    }
  }

  /// 🧩 Shows dialog for [Consumable<Failure>] without any reset logic.
  /// ✅ Use when no Bloc/form state mutation is needed after error.
  static void handle(BuildContext context, Consumable<Failure>? consumable) {
    final failure = consumable?.consume();
    if (failure != null) {
      OverlayNotificationService.dismissIfVisible();
      context.showFailureDialog(failure);
    }
  }

  //
}
