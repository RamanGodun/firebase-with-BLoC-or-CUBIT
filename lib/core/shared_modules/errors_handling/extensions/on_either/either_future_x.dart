part of '_either_x_imports.dart';

/// 🧩 [ResultFutureX<T>] — async sugar for `Future<Either<Failure, T>>`
/// ✅ Unified extension for async consumption and chaining of failures/success.

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
  Future<T> getOrElse(T fallback) async =>
      (await this).fold((_) => fallback, (r) => r);
  // Future<T> getOrElse(T fallback) async => (await this).rightOrNull ?? fallback; // this will be faster

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

  /// 💬 Show SnackBar if failure
  Future<void> handleSnackBar(BuildContext context) async {
    final result = await this;
    if (!context.mounted) return;
    result.handleSnackBar(context);
  }

  /// 💬 Show Dialog if failure
  Future<void> handleDialog(
    BuildContext context, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) async {
    final result = await this;
    if (!context.mounted) return;
    result.handleDialog(
      context,
      title: title,
      buttonText: buttonText,
      onClose: onClose,
    );
  }

  ///
}
