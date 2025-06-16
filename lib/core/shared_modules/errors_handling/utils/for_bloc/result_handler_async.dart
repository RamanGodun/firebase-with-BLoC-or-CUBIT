import 'dart:async' show FutureOr;
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/utils/observers/loggers/failure_logger_x.dart';
import '../../either/either.dart';
import '../../failures/failure_entity.dart';

/// 🧩 [ResultHandlerAsync<T>] — async wrapper around `Either<Failure, T>`
/// ✅ Provides clean async result handling with chainable syntax.
/// Useful for services, use-cases, and UI layers (e.g. after API calls).

class ResultHandlerAsync<T> {
  //------------------------

  final Either<Failure, T> result;
  const ResultHandlerAsync(this.result);

  /// ───────────────────────────────
  // 🔹 Async Callbacks
  // ───────────────────────────────

  /// 🔹 Runs [handler] if result is Right (success)
  Future<ResultHandlerAsync<T>> onSuccessAsync(
    FutureOr<void> Function(T value) handler,
  ) async {
    if (result.isRight) await handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Runs [handler] if result is Left (failure)
  Future<ResultHandlerAsync<T>> onFailureAsync(
    FutureOr<void> Function(Failure failure) handler,
  ) async {
    if (result.isLeft) await handler(result.leftOrNull!);
    return this;
  }

  /// ───────────────────────────────
  // 🔁 Fold
  // ───────────────────────────────

  /// 🔁 Fold logic for async success/failure handling
  Future<void> foldAsync({
    required FutureOr<void> Function(Failure failure) onFailure,
    required FutureOr<void> Function(T value) onSuccess,
  }) async {
    await result.fold(onFailure, onSuccess);
  }

  /// ───────────────────────────────
  // 🎯 Value Accessors
  // ───────────────────────────────

  /// ✅ Returns success value or fallback
  T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

  /// 📥 Gets success value (nullable)
  T? get valueOrNull => result.rightOrNull;

  /// ❌ Gets failure (nullable)
  Failure? get failureOrNull => result.leftOrNull;

  /// ───────────────────────────────
  // 🧪 Logging
  // ───────────────────────────────

  /// 🐞 Logs failure (Crashlytics or debugPrint)
  Future<ResultHandlerAsync<T>> logAsync() async {
    result.leftOrNull?.log();
    return this;
  }

  //
}
