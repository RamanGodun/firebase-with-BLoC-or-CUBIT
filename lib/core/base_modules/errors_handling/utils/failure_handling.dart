import 'package:firebase_with_bloc_or_cubit/core/base_modules/errors_handling/failures/extensions/failure_to_either_x.dart';
import '../either/either.dart';
import '../failures/failure_entity.dart';
import 'exceptions_to_failures_mapper/_exceptions_to_failures_mapper.dart';
import 'observers/loggers/errors_log_util.dart';

/// [WrapWithErrorHandling] - Abstract base class for use case implementations.
/// Provides a consistent method to wrap any async domain logic
/// and convert errors into [Failure] types for safe functional error handling.
//
abstract class WrapWithErrorHandling {
  /// ----------------------------
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

////

////

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
      ErrorsLogger.log(e, st);
      return ExceptionToFailureMapper.from(e, st).toLeft<T>();
    }
  }
}
