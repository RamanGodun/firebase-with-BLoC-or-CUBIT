// import 'dart:async' show FutureOr;

// import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either_for_data/either_x/either_getters_x.dart';
// import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_logger_x.dart';

// import '../either_for_data/either.dart';
// import '../failures_for_domain_and_presentation/failure_for_domain.dart';

// /// 🧩 [ResultHandlerAsync<T>] — async wrapper around `Either<Failure, T>`
// /// ✅ Provides clean async result handling with chainable syntax.
// /// Useful for services, use-cases, and UI layers (e.g. after API calls).
// //-------------------------------------------------------------------------

// class DSLLikeResultHandlerAsync<T> {
//   final Either<Failure, T> result;
//   const DSLLikeResultHandlerAsync(this.result);

//   // ──────────────────────────────────────────────────────────────────────
//   // 🔹 Async Callbacks
//   // ──────────────────────────────────────────────────────────────────────

//   /// 🔹 Runs [handler] if result is Right (success)
//   Future<DSLLikeResultHandlerAsync<T>> onSuccessAsync(
//     FutureOr<void> Function(T value) handler,
//   ) async {
//     if (result.isRight) await handler(result.rightOrNull as T);
//     return this;
//   }

//   /// 🔹 Runs [handler] if result is Left (failure)
//   Future<DSLLikeResultHandlerAsync<T>> onFailureAsync(
//     FutureOr<void> Function(Failure failure) handler,
//   ) async {
//     if (result.isLeft) await handler(result.leftOrNull!);
//     return this;
//   }

//   // ──────────────────────────────────────────────────────────────────────
//   // 🔁 Fold
//   // ──────────────────────────────────────────────────────────────────────

//   /// 🔁 Fold logic for async success/failure handling
//   Future<void> foldAsync({
//     required FutureOr<void> Function(Failure failure) onFailure,
//     required FutureOr<void> Function(T value) onSuccess,
//   }) async {
//     await result.fold(onFailure, onSuccess);
//   }

//   // ──────────────────────────────────────────────────────────────────────
//   // 🎯 Value Accessors
//   // ──────────────────────────────────────────────────────────────────────

//   /// ✅ Returns success value or fallback
//   T getOrElse(T fallback) => result.fold((_) => fallback, (r) => r);

//   /// 📥 Gets success value (nullable)
//   T? get valueOrNull => result.rightOrNull;

//   /// ❌ Gets failure (nullable)
//   Failure? get failureOrNull => result.leftOrNull;

//   // ──────────────────────────────────────────────────────────────────────
//   // 🧪 Logging
//   // ──────────────────────────────────────────────────────────────────────

//   /// 🐞 Logs failure (Crashlytics or debugPrint)
//   Future<DSLLikeResultHandlerAsync<T>> logAsync() async {
//     result.leftOrNull?.log();
//     return this;
//   }

//   ///
// }
