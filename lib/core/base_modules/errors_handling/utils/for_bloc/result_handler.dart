import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import 'package:flutter/material.dart';
import '../../either/either.dart';
import '../../failures/failure_entity.dart';

/// 🧩 [ResultHandler<T>] — wrapper around `Either<Failure, T>`
/// ✅ Chainable and readable result API for Cubits, Providers, UseCases.

@immutable
final class ResultHandler<T> {
  ///----------------------------

  final Either<Failure, T> result;
  const ResultHandler(this.result);

  /// ───────────────────────────────
  // 🔹 Success / Failure Callbacks
  // ───────────────────────────────

  /// 🔹 Executes handler if result is success
  ResultHandler<T> onSuccess(void Function(T value) handler) {
    if (result.isRight) handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Executes handler if result is failure
  ResultHandler<T> onFailure(void Function(Failure failure) handler) {
    if (result.isLeft) handler(result.leftOrNull!);
    return this;
  }

  /// ───────────────────────────────
  // 🎯 Accessors & Info
  // ───────────────────────────────

  /// ✅ Success value or fallback
  T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

  /// ✅ Nullable success
  T? get valueOrNull => result.rightOrNull;

  /// ❌ Nullable failure
  Failure? get failureOrNull => result.leftOrNull;

  /// ✅ Indicates if result is failure
  bool get didFail => result.isLeft;

  /// ✅ Indicates if result is success
  bool get didSucceed => result.isRight;

  /// ───────────────────────────────
  // 🔁 Fold Logic
  // ───────────────────────────────

  /// 🔁 Pattern match logic
  void fold({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) {
    result.fold(onFailure, onSuccess);
  }

  /// ───────────────────────────────
  // 🧪 Logging
  // ───────────────────────────────

  /// 🐞 Logs failure (debug or Crashlytics)
  ResultHandler<T> log() {
    result.leftOrNull?.log();
    return this;
  }

  //
}
