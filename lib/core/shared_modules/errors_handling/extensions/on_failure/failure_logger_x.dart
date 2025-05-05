

part of '_failure_x_imports.dart';

/// 🪵 [FailureLogger] — provides Crashlytics/debug logging and safe UI fallback message.
extension FailureLogger on Failure {
  /// Logs this failure (to console or Crashlytics, depending on environment).
  void log() => logFailureToCrashlytics(this);

  /// Human-friendly fallback message for UI display.
  String get uiMessage => message.isNotEmpty ? message : 'Something went wrong';
}

