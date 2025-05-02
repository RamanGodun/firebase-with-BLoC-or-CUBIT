import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/extensions/context_extensions/_context_extensions.dart';
import '../overlay/_overlay_service.dart';
import 'either/either.dart';
import 'extensions/failure_x.dart';
import 'failure.dart';

/// 🧩 [ResultHandler<T>] — top-tier wrapper for `Either <Failure, T>`
/// 🧼 Enables chainable actions like .onSuccess, .log, .showDialog, .fold, etc.
//----------------------------------------------------------------//
class ResultHandler<T> {
  final Either<Failure, T> result;

  ResultHandler(this.result);

  /// 🔹 Executes callback if value is success (Right)
  ResultHandler<T> onSuccess(void Function(T value) handler) {
    if (result.isRight) handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Executes callback if value is failure (Left)
  ResultHandler<T> onFailure(void Function(Failure failure) handler) {
    if (result.isLeft) handler(result.leftOrNull!);
    return this;
  }

  /// 🔹 Logs failure to Crashlytics or debug console
  ResultHandler<T> log() {
    result.leftOrNull?.log();
    return this;
  }

  /// 🔹 Returns Right value or fallback
  T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

  /// 🔹 Shortcut to access result value or null
  T? get valueOrNull => result.rightOrNull;

  /// 🔹 Shortcut to access failure or null
  Failure? get failureOrNull => result.leftOrNull;

  /// 🔹 Fold-style API
  void fold({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) {
    result.fold(onFailure, onSuccess);
  }

  /// 🔹 Shows a native-style dialog based on failure
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
