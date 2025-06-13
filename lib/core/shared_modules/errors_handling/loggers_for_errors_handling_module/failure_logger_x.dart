import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_diagnostics_x.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import '../failures/failure_for_domain.dart';
import 'errors_logger.dart';

/// 🧩 Extensions for `Failure`: logging, diagnostics, analytics
//-----------------------------------------------------------

extension FailureLogger on Failure {
  void log([StackTrace? stackTrace]) {
    ErrorsLogger.failure(this, stackTrace);
  }
}

extension FailureTrackX on Failure {
  Failure track(void Function(String eventName) trackCallback) {
    trackCallback('failure_${runtimeType.toString().toLowerCase()}');
    return this;
  }
}

extension FailureDebugX on Failure {
  Failure debugLog([String? label]) {
    final tag = label ?? 'Failure';
    debugPrint('[DEBUG][$tag] => $label — $message | status=$safeStatus');
    return this;
  }

  String get debugSummary => '[${runtimeType.toString()}] $label';

  ///
}
