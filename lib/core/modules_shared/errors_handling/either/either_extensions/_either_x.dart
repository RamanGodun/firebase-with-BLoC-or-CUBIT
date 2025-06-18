import 'package:firebase_with_bloc_or_cubit/core/modules_shared/errors_handling/failures/extensions/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../../failures/failure_entity.dart';
import '../../utils/observers/loggers/errors_log_util.dart';
import '__eithers_facade.dart';

/// 🧩 [ResultX<T>] — Sync sugar for `Either<Failure, T>`
/// ✅ Enables fallback values, failure access, and folding logic

extension ResultX<T> on Either<Failure, T> {
  //---------------------------------------

  /// 🔁 Match (fold) sync logic — now chainable
  /// ✅ Auto-logs failure and tracks success
  Either<Failure, T> match({
    required void Function(Failure failure) onFailure,
    required void Function(T value) onSuccess,
    String? successTag,
    StackTrace? stack,
  }) {
    fold(
      (f) {
        ErrorsLogger.failure(f, stack);
        onFailure(f);
      },
      (r) {
        final tag = successTag ?? 'Success';
        debugPrint('[SUCCESS][$tag] $r');
        onSuccess(r);
      },
    );
    return this;
  }

  /// 🎯 Returns value or fallback
  T getOrElse(T fallback) => fold((_) => fallback, (r) => r);

  /// 🧼 Returns failure message or null
  String? get failureMessage => fold((f) => f.message, (_) => null);

  /// 🔁 Maps right value
  Either<Failure, R> mapRight<R>(R Function(T value) transform) =>
      mapRight(transform);
  // Either<Failure, R> mapRight<R>(R Function(T value) transform) =>
  // fold((l) => Left(l), (r) => Right(transform(r)));

  /// 🔁 Maps left value
  Either<Failure, T> mapLeft(Failure Function(Failure failure) transform) =>
      mapLeft(transform);
  // Either<Failure, T> mapLeft(Failure Function(Failure failure) transform) =>
  //     fold((l) => Left(transform(l)), (r) => Right(r));

  /// 🔍 True if failure is Unauthorized
  bool get isUnauthorizedFailure => switch (this) {
    Left(:final value) => value.safeCode == 'UNAUTHORIZED',
    Right() => false,
  };

  /// 🔁 Emits state changes declaratively
  void emitStates({
    void Function()? emitLoading,
    required void Function(Failure) emitFailure,
    required void Function(T) emitSuccess,
  }) {
    emitLoading?.call();
    fold(emitFailure, emitSuccess);
  }

  //
}
