import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either/extensions/_either_x_imports.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/on_failure/_failure_x_imports.dart';
import 'package:flutter/material.dart';
import '../../../utils/extensions/context_extensions/_context_extensions.dart';
import '../../overlay/_overlay_service.dart';
import '../either/either.dart';
import '../failures/failure.dart';

/// 🧩 [ResultHandler] — wrapper around `Either<Failure, T>`
/// ✅ Provides clean, readable, chainable result handling for sync operations.
/// Useful for UseCases or repositories in domain layer.
//-------------------------------------------------------------------------

@immutable
final class ResultHandler<T> {
  final Either<Failure, T> result;

  const ResultHandler(this.result);

  // ──────────────────────────────────────────────────────────────────────
  // 🔹 Callbacks
  // ──────────────────────────────────────────────────────────────────────

  /// 🔹 Runs [handler] if result is Right (success)
  ResultHandler<T> onSuccess(void Function(T value) handler) {
    if (result.isRight) handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Runs [handler] if result is Left (failure)
  ResultHandler<T> onFailure(void Function(Failure failure) handler) {
    if (result.isLeft) handler(result.leftOrNull!);
    return this;
  }

  // ──────────────────────────────────────────────────────────────────────
  // 🎯 Value Accessors
  // ──────────────────────────────────────────────────────────────────────

  /// ✅ Returns success value or fallback
  T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

  /// 📥 Gets success value (nullable)
  T? get valueOrNull => result.rightOrNull;

  /// ❌ Gets failure (nullable)
  Failure? get failureOrNull => result.leftOrNull;

  // ──────────────────────────────────────────────────────────────────────
  // 🔁 Fold
  // ──────────────────────────────────────────────────────────────────────

  /// 🔁 Fold logic for explicit success or failure handling
  void fold({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) {
    result.fold(onFailure, onSuccess);
  }

  // ──────────────────────────────────────────────────────────────────────
  // 🧪 Logging
  // ──────────────────────────────────────────────────────────────────────

  /// 🐞 Logs failure (Crashlytics or debugPrint)
  ResultHandler<T> log() {
    result.leftOrNull?.log();
    return this;
  }

  // ──────────────────────────────────────────────────────────────────────
  // 💬 UI Dialog
  // ──────────────────────────────────────────────────────────────────────

  /// 💬 Displays a dialog if failure exists
  Future<ResultHandler<T>> showDialog(
    BuildContext context, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) async {
    if (!context.mounted) return this;
    final failure = result.leftOrNull;
    if (failure != null) {
      OverlayNotificationService.dismissIfVisible();
      context.showFailureDialog(
        failure,
        title: title,
        buttonText: buttonText,
        onClose: onClose,
      );
    }
    return this;
  }

  ///
}
