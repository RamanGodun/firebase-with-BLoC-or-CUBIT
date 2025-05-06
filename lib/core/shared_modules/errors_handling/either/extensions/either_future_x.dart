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

  /// 🔁 Match with sync callbacks (after await)
  Future<void> matchSync({
    required void Function(Failure) onFailure,
    required void Function(T) onSuccess,
  }) async => (await this).fold(onFailure, onSuccess);

  /// 🎯 Get value or fallback
  Future<T> getOrElse(T fallback) async => (await this).rightOrNull ?? fallback;

  /// 🧼 Extract failure message or null
  Future<String?> failureMessageOrNull() async =>
      (await this).fold((f) => f.message, (_) => null);

  /// 🔹 Runs failure handler if result is Left
  Future<ResultHandler<T>> onFailure(
    FutureOr<void> Function(Failure f) handler,
  ) async {
    final result = await this;
    if (result.isLeft) await handler(result.leftOrNull!);
    return ResultHandler(result);
  }

  ///
}
