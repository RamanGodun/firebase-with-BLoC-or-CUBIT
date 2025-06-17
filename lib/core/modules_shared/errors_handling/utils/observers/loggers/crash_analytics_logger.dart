import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import '../../../failures/failure_entity.dart';
import '../failure_diagnostics_x.dart';

/// 🧱 [CrashlyticsLogger] — Utility class for sending structured logs to Firebase Crashlytics.
/// ✅ Handles exceptions, domain-level failures, and Bloc observer errors.
/// ✅ Prints debug output in development mode for immediate visibility.

abstract final class CrashlyticsLogger {
  const CrashlyticsLogger._();
  //---------------------------

  /// 🧩 Internal helper for consistent error reporting.
  static void _record({
    required Object error,
    required StackTrace stackTrace,
    required String reason,
  }) {
    if (kDebugMode) debugPrint(reason);
    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: reason,
      fatal: false,
    );
  }

  /// ❗ Logs uncaught exceptions and raw errors.
  static void exception(Object error, [StackTrace? stackTrace]) {
    final reason = '[UNHANDLED][${error.runtimeType}] $error';
    _record(
      error: error,
      stackTrace: stackTrace ?? StackTrace.current,
      reason: reason,
    );
  }

  /// 🧱 Logs mapped [Failure] objects from the domain layer.
  static void failure(Failure failure, [StackTrace? stackTrace]) {
    final reason =
        '[FAILURE][${failure.pluginSource}][${failure.safeCode}] ${failure.message}';
    _record(
      error: failure,
      stackTrace: stackTrace ?? StackTrace.current,
      reason: reason,
    );
  }

  /// 🧨 Logs errors from Bloc or Cubit observers.
  static void blocError({
    required Object error,
    required StackTrace stackTrace,
    required String origin,
  }) {
    final reason = '[BLoC][$origin][${error.runtimeType}] $error';
    _record(error: error, stackTrace: stackTrace, reason: reason);
  }

  /// 🗂 Logs general info (non-error, non-crash messages).
  static void log(String message) {
    if (kDebugMode) debugPrint('[LOG] $message');
    FirebaseCrashlytics.instance.log(message);
  }

  //
}
