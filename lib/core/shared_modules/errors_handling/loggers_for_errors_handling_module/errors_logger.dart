import 'package:flutter/foundation.dart' show debugPrint;
import '../failures/failure_for_domain.dart';

/// 🧭 [ErrorsLogger] — Centralized logger for all application-level telemetry.
/// 🔍 Supports runtime exceptions and domain-level failures
///-----------------------------------------------------------------------------

abstract final class ErrorsLogger {
  const ErrorsLogger._();

  /// ❗ Logs any raw [Exception] or [Error].
  static void exception(Object error, [StackTrace? stackTrace]) {
    debugPrint('[Exception] ${error.runtimeType}: $error');
    if (stackTrace case final trace?) debugPrint(trace.toString());
  }

  /// 🧱 Logs a domain-level [Failure].
  static void failure(Failure failure, [StackTrace? stackTrace]) {
    debugPrint('[Failure] ${failure.runtimeType}: $failure');
    if (stackTrace case final trace?) debugPrint(trace.toString());
  }

  static void log(Object error, [StackTrace? stackTrace]) {
    ErrorsLogger.exception(error, stackTrace);
  }

  ///
}
