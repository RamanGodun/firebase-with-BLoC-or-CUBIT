import 'package:flutter/foundation.dart' show debugPrint;
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_errors_handling/either_for_data/_eithers_facade.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_loggers/_app_error_logger.dart';
import '../app_errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';

/// 📦 [ResultLoggerExt<T>] — Unified logging extensions for Either and [Future<Either>]
/// ✅ Supports logging, tracking, and success/failure diagnostics
//-------------------------------------------------------------------------

extension ResultLoggerExt<T> on Either<Failure, T> {
  /// 🪵 Logs failure if result is Left
  Either<Failure, T> log([StackTrace? stack]) {
    if (isLeft) AppLogger.logFailure(leftOrNull!, stack);
    return this;
  }

  /// 📈 Logs success value to console if result is Right
  Either<Failure, T> logSuccess([String? label]) {
    if (isRight) {
      final tag = label ?? 'Success';
      debugPrint('[SUCCESS][$tag] \$rightOrNull');
    }
    return this;
  }

  /// 📊 Tracks event name (analytics hook)
  Either<Failure, T> track(String eventName) {
    if (isRight) debugPrint('[TRACK] \$eventName');
    return this;
  }
}

extension FutureResultLoggerExt<T> on Future<Either<Failure, T>> {
  /// 🪵 Logs failure if result is Left
  Future<Either<Failure, T>> log([StackTrace? stack]) async {
    final result = await this;
    if (result.isLeft) AppLogger.logFailure(result.leftOrNull!, stack);
    return result;
  }

  /// 📈 Logs success value to console if result is Right
  Future<Either<Failure, T>> logSuccess([String? tag]) async {
    final result = await this;
    if (result.isRight) {
      //!  final resolved = tag ?? 'Success';
      debugPrint('[SUCCESS][\$resolved] \${result.rightOrNull}');
    }
    return result;
  }

  /// 📊 Tracks event if result is successful
  Future<Either<Failure, T>> track(String eventName) async {
    final result = await this;
    if (result.isRight) debugPrint('[TRACK] \$eventName');
    return result;
  }
}
