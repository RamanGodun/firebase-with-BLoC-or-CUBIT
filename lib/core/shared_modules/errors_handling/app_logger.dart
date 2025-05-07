import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/_failure_x_imports.dart';
import 'package:flutter/foundation.dart';
import 'failures/failure.dart';

/// 🧭 [AppErrorLogger] — Centralized logger for all application-level errors.
/// ✅ Unified entry point for logging:
/// - Raw [Exception]/[Error] from SDK/API (before mapping)
/// - Domain-level [Failure] after mapping
/// - Bloc-related errors from [BlocObserver]

/// ✅ Used internally by:
///     - `Failure.log()`
///     - `FailureMapper.from(...)`
///     - `BlocObserver.onError(...)`
///     - `ResultHandler.log()` / `ResultHandlerAsync.logAsync()`
///-----------------------------------------------------------------------------

abstract final class AppErrorLogger {
  const AppErrorLogger._();

  /// ❗ Logs any raw [Exception] or [Error] before mapping to [Failure].
  ///
  /// Typically called from [FailureMapper] when catching unknown exceptions.
  static void logException(Object error, [StackTrace? stackTrace]) {
    final type = error.runtimeType;
    final message = error.toString();

    if (kDebugMode) {
      debugPrint('[UNHANDLED][$type] $message');
    }

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace ?? StackTrace.current,
      reason: '[UNHANDLED][$type] $message',
      fatal: false,
    );
  }

  /// 🔁 Logs a domain-level [Failure] after it has been mapped.
  /// Typically used inside `Failure.log()` and `ResultHandler.log()`.
  static void logFailure(Failure failure, [StackTrace? stackTrace]) {
    final type = failure.runtimeType;
    final source = failure.pluginSource;
    final label = failure.message;

    if (kDebugMode) {
      debugPrint('[FAILURE][$source][$type] $label');
    }

    FirebaseCrashlytics.instance.recordError(
      failure,
      stackTrace ?? StackTrace.current,
      reason: '[FAILURE][$source][$type] $label',
      fatal: false,
    );
  }

  /// 🧨 Logs errors originating from the BLoC system.
  /// Used in [BlocObserver.onError] to trace state-related failures.
  static void logBlocError({
    required Object error,
    required StackTrace stackTrace,
    required String origin,
  }) {
    final type = error.runtimeType;
    final message = error.toString();

    if (kDebugMode) {
      debugPrint('[BLoC][$origin][$type] $message');
    }

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: '[BLoC][$origin][$type] $message',
      fatal: false,
    );
  }

  ///
}
