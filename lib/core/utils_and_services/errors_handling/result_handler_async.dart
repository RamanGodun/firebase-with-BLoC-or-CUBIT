import 'dart:async';
import 'package:flutter/material.dart';
import '../extensions/context_extensions/_context_extensions.dart';
import 'either/either.dart';
import 'extensions/failure_x.dart';
import 'failure.dart';

/// 🧩 [ResultHandlerAsync<T>] — async wrapper for `Either<Failure, T>`
/// 🧼 Enables fully async chainable API (.onSuccessAsync, .onFailureAsync, .logAsync, etc.)
//----------------------------------------------------------------//
class ResultHandlerAsync<T> {
  final Either<Failure, T> result;

  const ResultHandlerAsync(this.result);

  /// 🔹 Executes async callback if value is success (Right)
  Future<ResultHandlerAsync<T>> onSuccessAsync(
    FutureOr<void> Function(T value) handler,
  ) async {
    if (result.isRight) await handler(result.rightOrNull as T);
    return this;
  }

  /// 🔹 Executes async callback if value is failure (Left)
  Future<ResultHandlerAsync<T>> onFailureAsync(
    FutureOr<void> Function(Failure failure) handler,
  ) async {
    if (result.isLeft) await handler(result.leftOrNull!);
    return this;
  }

  /// 🔹 Logs failure asynchronously (Crashlytics or console)
  Future<ResultHandlerAsync<T>> logAsync() async {
    result.leftOrNull?.log();
    return this;
  }

  /// 🔹 Shows a native-style dialog based on failure
  Future<ResultHandlerAsync<T>> showDialog(
    BuildContext context, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) async {
    if (!context.mounted) return this;
    final failure = result.leftOrNull;
    if (failure != null) {
      context.showFailureDialog(
        failure,
        title: title,
        buttonText: buttonText,
        onClose: onClose,
      );
    }
    return this;
  }

  /// 🔹 Fold-style async API
  Future<void> foldAsync({
    required FutureOr<void> Function(Failure failure) onFailure,
    required FutureOr<void> Function(T value) onSuccess,
  }) async {
    await result.fold(onFailure, onSuccess);
  }

  /// 🔹 Returns Right value or fallback
  T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

  /// 🔹 Access Right value or null
  T? get valueOrNull => result.rightOrNull;

  /// 🔹 Access Failure or null
  Failure? get failureOrNull => result.leftOrNull;
}

/// 🧩 Extension for async instantiation from `Future<Either<Failure, T>>`
extension ResultFutureHandlerAsyncX<T> on Future<Either<Failure, T>> {
  Future<ResultHandlerAsync<T>> asResultHandlerAsync() async {
    final result = await this;
    return ResultHandlerAsync(result);
  }
}


