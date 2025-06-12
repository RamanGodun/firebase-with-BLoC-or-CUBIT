// import 'dart:async' show FutureOr;
// import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_logger_x.dart';
// import 'package:flutter/foundation.dart' show immutable;
// import '../either_for_data/either_x/_eithers_facade.dart';
// import '../failures_for_domain_and_presentation/failure_for_domain.dart';

// /// 🧩 [DSLLikeResultHandler<T>] — wrapper for `Either<Failure, T>`
// /// ✅ Clean, chainable result handling with both sync & async APIs
// /// ✅ Unified for use in Providers, Cubits, UseCases, UI, etc.
// /// ─────

// @immutable
// final class DSLLikeResultHandler<T> {
//   final Either<Failure, T> result;
//   const DSLLikeResultHandler(this.result);

//   /// 🔒 Internal: result is success
//   bool get _isSuccess => result.isRight;

//   /// 🔒 Internal: result is failure
//   bool get _isFailure => result.isLeft;

//   /// 🔒 Internal: success value (non-nullable)
//   T get _successValue => result.rightOrNull as T;

//   /// 🔒 Internal: failure value (non-nullable)
//   Failure get _failureValue => result.leftOrNull!;

//   //──────────────────────────────────────────────────────────────────────
//   // 🔹 Success / Failure Callbacks (SYNC)
//   //──────────────────────────────────────────────────────────────────────

//   /// 🔹 Executes [handler] if result is success (sync)
//   DSLLikeResultHandler<T> onSuccess(void Function(T value) handler) {
//     if (_isSuccess) handler(_successValue);
//     return this;
//   }

//   /// 🔹 Executes [handler] if result is failure (sync)
//   DSLLikeResultHandler<T> onFailure(void Function(Failure failure) handler) {
//     if (_isFailure) handler(_failureValue);
//     return this;
//   }

//   //──────────────────────────────────────────────────────────────────────
//   // 🔹 Success / Failure Callbacks (ASYNC)
//   //──────────────────────────────────────────────────────────────────────

//   /// 🔹 Executes [handler] if result is success (async)
//   Future<DSLLikeResultHandler<T>> onSuccessAsync(
//     FutureOr<void> Function(T value) handler,
//   ) async {
//     if (_isSuccess) await handler(_successValue);
//     return this;
//   }

//   /// 🔹 Executes [handler] if result is failure (async)
//   Future<DSLLikeResultHandler<T>> onFailureAsync(
//     FutureOr<void> Function(Failure failure) handler,
//   ) async {
//     if (_isFailure) await handler(_failureValue);
//     return this;
//   }

//   //──────────────────────────────────────────────────────────────────────
//   // 🔁 Fold Logic
//   //──────────────────────────────────────────────────────────────────────

//   /// 🔁 Pattern match logic (sync)
//   void fold({
//     required void Function(Failure failure) onFailure,
//     required void Function(T value) onSuccess,
//   }) {
//     result.fold(onFailure, onSuccess);
//   }

//   /// 🔁 Pattern match logic (async)
//   Future<void> foldAsync({
//     required FutureOr<void> Function(Failure failure) onFailure,
//     required FutureOr<void> Function(T value) onSuccess,
//   }) async {
//     await result.fold(onFailure, onSuccess);
//   }

//   //──────────────────────────────────────────────────────────────────────
//   // 🎯 Accessors
//   //──────────────────────────────────────────────────────────────────────

//   /// ✅ Returns success value or fallback
//   T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

//   /// ✅ Nullable success
//   T? get valueOrNull => result.rightOrNull;

//   /// ❌ Nullable failure
//   Failure? get failureOrNull => result.leftOrNull;

//   /// ✅ Indicates if result is failure
//   bool get didFail => _isFailure;

//   /// ✅ Indicates if result is success
//   bool get didSucceed => _isSuccess;

//   //──────────────────────────────────────────────────────────────────────
//   // 🧪 Logging
//   //──────────────────────────────────────────────────────────────────────

//   /// 🐞 Logs failure (debug or Crashlytics)
//   DSLLikeResultHandler<T> log() {
//     _failureValue.log();
//     return this;
//   }

//   /// 🐞 Logs failure (async)
//   Future<DSLLikeResultHandler<T>> logAsync() async {
//     _failureValue.log();
//     return this;
//   }

//   ///
// }
