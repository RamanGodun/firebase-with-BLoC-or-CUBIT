part of '_failure_x_imports.dart';

/// 🪵 [FailureLogger] — provides Crashlytics/debug logging.
/// ✅ Use `failure.log()` to record and trace errors.

/// 🪵 [FailureLogger] — centralized, minimal & non-redundant logging mechanism for `Failure`s
/// Automatically defers logging to `FailureMapper` if raw error is handled there.
//-------------------------------------------------------------------------

extension FailureLogger on Failure {
  /// Logs this failure (used in ResultHandler or manually).
  void log({StackTrace? stackTrace}) {
    AppErrorLogger.logFailure(this, stackTrace);
  }
}
