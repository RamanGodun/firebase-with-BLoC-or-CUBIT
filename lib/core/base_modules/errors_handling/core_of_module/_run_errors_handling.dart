import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/utils/errors_observing/loggers/failure_logger_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/core_of_module/utils/extensions_on_failure/failure_to_either_x.dart';
import 'either.dart';
import 'failure_entity.dart';
import 'dart:async' show TimeoutException;
import 'dart:convert' show JsonUnsupportedObjectError;
import 'dart:io' show FileSystemException, SocketException;
import 'package:dio/dio.dart' show DioException, DioExceptionType;
import 'package:firebase_core/firebase_core.dart' show FirebaseException;
import 'package:flutter/services.dart'
    show MissingPluginException, PlatformException;
import 'failure_type.dart';
import 'utils/errors_observing/loggers/errors_log_util.dart';

part '../extensible_part/exceptions_to_failure_mapping/_exceptions_to_failures_mapper_x.dart';
part '../extensible_part/exceptions_to_failure_mapping/firebase_exceptions_mapper.dart';
part '../extensible_part/exceptions_to_failure_mapping/dio_exceptions_mapper.dart';

/// [ResultFutureExtension] - Extension for async function types.
/// Provides a declarative way to wrap any async operation
/// with failure mapping and functional error handling.
//
extension ResultFutureExtension<T> on Future<T> Function() {
  //
  /// Executes the function, returning [Right] on success,
  /// or [Left] with mapped [Failure] on error.
  Future<Either<Failure, T>> runWithErrorHandling() async {
    try {
      final result = await this();
      return Right(result);
    } catch (e, st) {
      // return ExceptionToFailureMapper.from(e, st).toLeft<T>();
      // 🧼 Logging and mapping built-in here
      ErrorsLogger.log(e, st);

      ///🛡️ Ensures that [e] is domain-level [Failure], otherwise converts any caught raw exceptions into [Failure].
      final failure = e is Failure ? e : e.mapToFailure(st);
      return failure.toLeft<T>();
      //
    }
  }
}

////

////

/*
? Alternative

/// [WrapWithErrorHandling] - Abstract base class for use case implementations.
/// Provides a consistent method to wrap any async domain logic
/// and convert errors into [Failure] types for safe functional error handling.
//
abstract final class WrapWithErrorHandling {
  /// -----------------------------------
  //
  /// Executes a given async operation and returns an [Either] type.
  /// On success: returns [Right] with the result.
  /// On error: maps the exception to a [Failure] and returns [Left].
  Future<Either<Failure, T>> runSafely<T>(
    Future<T> Function() operation,
  ) async {
    try {
      final result = await operation();
      return Right(result);
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      return ExceptionToFailureMapper.from(e, st).toLeft<T>();
    }
  }
}

 */
