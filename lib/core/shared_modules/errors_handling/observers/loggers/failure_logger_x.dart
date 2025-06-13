import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/observers/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../../failures/failure_entity.dart';
import 'errors_log_util.dart';

/// 🧩 [Failure] extensions — logging, diagnostics, analytics hooks
/// ✅ Track, debug, and log failures in structured way

extension FailureLogger on Failure {
  //-------------------------------

  /// 🐞 Logs failure to logger (e.g. Crashlytics)
  void log([StackTrace? stackTrace]) {
    ErrorsLogger.failure(this, stackTrace);
  }

  /// 🐛 Prints debug info with optional label
  Failure debugLog([String? label]) {
    final tag = label ?? 'Failure';
    debugPrint('[DEBUG][$tag] => $label — $message | status=$safeStatus');
    return this;
  }

  /// 📝 Summary string for quick diagnostics
  String get debugSummary => '[${runtimeType.toString()}] $label';

  /// 📊 Tracks failure event using analytics callback
  Failure track(void Function(String eventName) trackCallback) {
    trackCallback('failure_${safeCode.toLowerCase()}');
    return this;
  }

  //
}
