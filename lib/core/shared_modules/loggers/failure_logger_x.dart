import '../errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '_app_error_logger.dart';

/// 🪵 [FailureLogger] — provides Crashlytics/debug logging.
/// ✅ Use `failure.log()` to record and trace errors.

/// 🪵 [FailureLogger] — centralized, minimal & non-redundant logging mechanism for `Failure`s
/// Automatically defers logging to `FailureMapper` if raw error is handled there.
//-------------------------------------------------------------------------

///  [FailureLogger] — Logs [Failure] using AppErrorLogger
extension FailureLogger on Failure {
  void log([StackTrace? stackTrace]) {
    AppErrorLogger.logFailure(this, stackTrace);
  }
}

/// 🐞 [RawErrorLogger] — Logs raw [Exception] before mapping to [Failure]
final class RawErrorLogger {
  const RawErrorLogger._();

  static void log(Object error, [StackTrace? stackTrace]) {
    AppErrorLogger.logException(error, stackTrace);
  }
}
