import 'dart:async' show FutureOr;
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either/either_extensions/either_getters_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../../loggers_for_errors_handling_module/errors_logger.dart';
import '../../utils/dsl_result_handler_async.dart';
import '../either.dart';
import '../../failures/failure_for_domain.dart';

/// 🧩 [ResultFutureX<T>] — Async sugar for `Future<Either<Failure, T>>`
/// ✅ Unified access to async chaining, fallback and message handling

extension ResultFutureX<T> on Future<Either<Failure, T>> {
  //-----------------------------------------------------

  /// 🔁 Match with async callbacks — auto-logs failure and tracks success
  Future<void> matchAsync({
    required Future<void> Function(Failure) onFailure,
    required Future<void> Function(T) onSuccess,
    String? successTag,
    StackTrace? stack,
  }) async {
    final result = await this;
    return result.fold(
      (f) async {
        ErrorsLogger.failure(f, stack);
        await onFailure(f);
      },
      (r) async {
        final tag = successTag ?? 'Success';
        debugPrint('[SUCCESS][$tag] \$r');
        await onSuccess(r);
      },
    );
  }

  /// 🎯 Get value or fallback
  Future<T> getOrElse(T fallback) async => (await this).rightOrNull ?? fallback;

  /// 🧼 Extract failure message or null
  Future<String?> failureMessageOrNull() async =>
      (await this).fold((f) => f.message, (_) => null);

  /// 🔹 Runs failure handler if result is Left
  Future<ResultHandlerAsync<T>> onFailure(
    FutureOr<void> Function(Failure f) handler,
  ) async {
    final result = await this;
    if (result.isLeft) await handler(result.leftOrNull!);
    return ResultHandlerAsync(result);
  }

  /// 🔁 Maps Right value using async transformation
  Future<Either<Failure, R>> mapRightAsync<R>(
    Future<R> Function(T r) transform,
  ) async {
    final result = await this;
    return switch (result) {
      Left(:final value) => Left(value),
      Right(:final value) => Right(await transform(value)),
    };
  }

  /// 🔁 Chains async transformation producing another Either
  Future<Either<Failure, R>> flatMapAsync<R>(
    Future<Either<Failure, R>> Function(T r) transform,
  ) async {
    final result = await this;
    return switch (result) {
      Left(:final value) => Left(value),
      Right(:final value) => await transform(value),
    };
  }

  /// 🔁 Executes fallback logic if result is Left
  Future<Either<Failure, T>> recover(
    FutureOr<T> Function(Failure f) recoverFn,
  ) async {
    final result = await this;
    return switch (result) {
      Left(:final value) => Right(await recoverFn(value)),
      Right() => result,
    };
  }

  /// 🔁 Retries the Future if result is failure, up to [maxAttempts]
  Future<Either<Failure, T>> retry({
    required Future<Either<Failure, T>> Function() task,
    int maxAttempts = 3,
    Duration delay = const Duration(milliseconds: 500),
  }) async {
    var result = await task();
    var attempt = 1;
    while (result.isLeft && attempt < maxAttempts) {
      await Future.delayed(delay);
      result = await task();
      attempt++;
    }
    return result;
  }

  //
}
