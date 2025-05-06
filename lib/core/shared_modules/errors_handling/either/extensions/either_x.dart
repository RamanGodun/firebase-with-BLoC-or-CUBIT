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
}
