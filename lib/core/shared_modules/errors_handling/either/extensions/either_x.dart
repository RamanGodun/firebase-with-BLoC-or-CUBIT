part of '_either_x_imports.dart';

/// 🧩 [ResultX<T>] — Sync sugar for `Either<Failure, T>`
/// ✅ Enables fallback values, failure access, and folding logic
//-------------------------------------------------------------------------
extension ResultX<T> on Either<Failure, T> {
  /// 🔁 Match (fold) sync logic
  void match({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
  }) => fold(onFailure, onSuccess);

  /// 🎯 Returns value or fallback
  T getOrElse(T fallback) => fold((_) => fallback, (r) => r);

  /// 🧼 Returns failure message or null
  String? get failureMessage => fold((f) => f.message, (_) => null);

  ///
  /// 🔁 Maps right value
  Either<Failure, R> mapRight<R>(R Function(T value) transform) =>
      mapRight(transform);

  /// 🔁 Maps left value
  Either<Failure, T> mapLeft(Failure Function(Failure failure) transform) =>
      mapLeft(transform);

  /// 🔍 True if failure is Unauthorized
  bool get isUnauthorizedFailure => switch (this) {
    Left(:final value) => value.safeCode == 'UNAUTHORIZED',
    Right() => false,
  };

  /// 🌀 Emits states to cubit based on result
  /// Usage:
  /// ```dart
  /// result.emitStates(
  ///   emitLoading: () => emit(Loading()),
  ///   emitFailure: (f) => emit(Failed(f)),
  ///   emitSuccess: (data) => emit(Success(data)),
  /// );
  /// ```
  void emitStates({
    void Function()? emitLoading,
    required void Function(Failure) emitFailure,
    required void Function(T) emitSuccess,
  }) {
    emitLoading?.call();
    fold(emitFailure, emitSuccess);
  }

  ///
}
