import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/overlay/overlay_dsl_x.dart';
import '../failures/failure_ui_model.dart';
import 'consumable.dart';

/// 📌 [FailureNotifier] — Unified handler for showing failure overlays.
/// ✅ Fully aligned with OverlayDispatcher and `context.overlay` system
final class FailureNotifier {
  /// 🧩 Handles a one-shot [FailureUIModel] and then resets the state
  static void handleAndReset(
    BuildContext context,
    Consumable<FailureUIModel>? consumable, {
    required VoidCallback onReset,
  }) {
    final model = consumable?.consume();
    if (model != null) {
      context.overlay.showError(model);
      Future.delayed(const Duration(milliseconds: 300), () {
        if (!context.mounted) return;
        onReset();
      });
    }
  }

  /// 🧩 Shows the overlay error without clearing the state
  static void handle(
    BuildContext context,
    Consumable<FailureUIModel>? consumable,
  ) {
    final model = consumable?.consume();
    if (model != null) context.overlay.showError(model);
  }
}
