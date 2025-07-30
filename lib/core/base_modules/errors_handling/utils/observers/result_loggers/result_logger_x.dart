import 'package:flutter/foundation.dart' show debugPrint;
import '../../../either/either_extensions/__eithers_facade.dart';
import '../../../failures/failure__entity.dart';
import '../loggers/errors_log_util.dart';

part 'async_result_logger.dart';

/// 📦 [ResultLoggerExt<T>] — Unified logging extensions for Either and [Future<Either>]
/// ✅ Supports logging, tracking, and success/failure diagnostics
//
extension ResultLoggerExt<T> on Either<Failure, T> {
  ///---------------------------------------------

  /// 🪵 Logs failure if result is Left
  Either<Failure, T> log([StackTrace? stack]) {
    if (isLeft) ErrorsLogger.failure(leftOrNull!, stack);
    return this;
  }

  /// 📈 Logs success value to console if result is Right
  Either<Failure, T> logSuccess([String? label]) {
    if (isRight) {
      final tag = label ?? 'Success';
      debugPrint('[SUCCESS][$tag] $rightOrNull');
    }
    return this;
  }

  /// 📊 Tracks event name (analytics hook)
  Either<Failure, T> track(String eventName) {
    if (isRight) debugPrint('[TRACK] $eventName');
    return this;
  }

  //
}
