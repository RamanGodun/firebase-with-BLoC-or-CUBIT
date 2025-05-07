part of '_failure_x_imports.dart';

/// 🪵 [FailureLogger] — provides Crashlytics/debug logging.
/// ✅ Use `failure.log()` to record and trace errors.
//-------------------------------------------------------------------------

extension FailureLogger on Failure {
  //
  /// Logs this failure (to console or Crashlytics, depending on environment).
  void log() => _logToCrashlytics(this);

  /// 🪵 Logs a [Failure] to Crashlytics or console.
  /// Replace with `FirebaseCrashlytics.instance.recordError(...)` in production.
  void _logToCrashlytics(Failure failure) {
    final label = failure.label;
    final type = failure.runtimeType.toString();
    final source = failure.pluginSource;

    debugPrint('[FAILURE][$source][$type] $label');

    ///
    /// ?TODO: FirebaseCrashlytics.instance.recordError(failure, StackTrace.current);
  }
}
