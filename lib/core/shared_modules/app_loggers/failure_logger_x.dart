import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_errors_handling/failures_for_domain_and_presentation/failure_x/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../app_errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '_app_error_logger.dart';

/// 🪵 [FailureLogger] — provides Crashlytics/debug logging.
/// ✅ Use `failure.log()` to record and trace errors.

/// 🪵 [FailureLogger] — centralized, minimal & non-redundant logging mechanism for `Failure`s
/// Automatically defers logging to `FailureMapper` if raw error is handled there.
//-------------------------------------------------------------------------

///  [FailureLogger] — Logs [Failure] using AppErrorLogger
extension FailureLogger on Failure {
  void log([StackTrace? stackTrace]) {
    AppLogger.logFailure(this, stackTrace);
  }
}

/// 🐞 [RawErrorLogger] — Logs raw [Exception] before mapping to [Failure]
final class RawErrorLogger {
  const RawErrorLogger._();

  static void log(Object error, [StackTrace? stackTrace]) {
    AppLogger.logException(error, stackTrace);
  }
}

/// 📈 [FailureTrackX] — Triggers analytics or diagnostic events for failures
// -----------------------------------------------------------------------------
extension FailureTrackX on Failure {
  /// 📊 Logs a track event based on failure type
  /// 💡 Replace [trackCallback] with actual analytics (e.g. FirebaseAnalytics.logEvent)
  Failure track(void Function(String eventName) trackCallback) {
    trackCallback('failure_${runtimeType.toString().toLowerCase()}');
    return this;
  }
}

/// 🖨️ [FailureDebugX] — Adds better developer feedback for debugging
// -----------------------------------------------------------------------------
extension FailureDebugX on Failure {
  /// 📋 Prints formatted error to debug console
  Failure debugLog([String? label]) {
    final tag = label ?? 'Failure';
    debugPrint('[DEBUG][$tag] => $label — $message | status=$safeStatus');
    return this;
  }

  /// 🧪 For golden test snapshots or snapshots
  String get debugSummary => '[${runtimeType.toString()}] $label';
}
