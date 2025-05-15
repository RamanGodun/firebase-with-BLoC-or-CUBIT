import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_errors_handling/failures_for_domain_and_presentation/failure_x/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint, kDebugMode;

import '../app_errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import 'i_logger_contract.dart';

/// 🧱 [CrashlyticsLogger] — Concrete implementation of [ILogger] using Firebase Crashlytics.
/// ✅ Sends structured error data to Crashlytics and optionally logs to console in debug mode.
///-----------------------------------------------------------------------------

final class CrashlyticsLogger implements ILogger {
  /// ❗ Logs any raw [Exception] or [Error] before mapping to [Failure].
  /// Typically used in [FailureMapper] and other pre-domain entry points.
  @override
  void logException(Object error, [StackTrace? stackTrace]) {
    final type = error.runtimeType;
    final message = error.toString();

    if (kDebugMode) debugPrint('[UNHANDLED][$type] $message');

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace ?? StackTrace.current,
      reason: '[UNHANDLED][$type] $message',
      fatal: false,
    );
  }

  /// 🔁 Logs a domain-level [Failure] after it has been mapped.
  /// Used in `Failure.log()`, `ResultHandler.log()` and similar.
  @override
  void logFailure(Failure failure, [StackTrace? stackTrace]) {
    final type = failure.runtimeType;
    final source = failure.pluginSource;
    final label = failure.message;

    if (kDebugMode) debugPrint('[FAILURE][$source][$type] $label');

    FirebaseCrashlytics.instance.recordError(
      failure,
      stackTrace ?? StackTrace.current,
      reason: '[FAILURE][$source][$type] $label',
      fatal: false,
    );
  }

  /// 🧨 Logs errors originating from the BLoC system.
  /// Called by [AppBlocObserver.onError] to trace state-related issues.
  @override
  void logBlocError({
    required Object error,
    required StackTrace stackTrace,
    required String origin,
  }) {
    final type = error.runtimeType;
    final message = error.toString();

    if (kDebugMode) debugPrint('[BLoC][$origin][$type] $message');

    FirebaseCrashlytics.instance.recordError(
      error,
      stackTrace,
      reason: '[BLoC][$origin][$type] $message',
      fatal: false,
    );
  }

  ///
}
