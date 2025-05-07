part of '_either_x_imports.dart';

/// 🧩 [ResultFutureX<T>] — Async sugar for `Future<Either<Failure, T>>`
/// ✅ Unified access to async chaining, fallback and message handling
//-------------------------------------------------------------------------

extension ResultFutureX<T> on Future<Either<Failure, T>> {
  /// 🔁 Match with async callbacks
  Future<void> matchAsync({
    required Future<void> Function(Failure) onFailure,
    required Future<void> Function(T) onSuccess,
  }) async => (await this).fold(onFailure, onSuccess);

  /// 🎯 Get value or fallback
  Future<T> getOrElse(T fallback) async => (await this).rightOrNull ?? fallback;

  /// 🧼 Extract failure message or null
  Future<String?> failureMessageOrNull() async =>
      (await this).fold((f) => f.message, (_) => null);

  /// 🔹 Runs failure handler if result is Left
  Future<DSLLikeResultHandler<T>> onFailure(
    FutureOr<void> Function(Failure f) handler,
  ) async {
    final result = await this;
    if (result.isLeft) await handler(result.leftOrNull!);
    return DSLLikeResultHandler(result);
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
    int attempt = 0;
    Either<Failure, T> result = await this;
    while (result.isLeft && attempt < maxAttempts) {
      await Future.delayed(delay);
      result = await task();
      attempt++;
    }
    return result;
  }

  ///
}
