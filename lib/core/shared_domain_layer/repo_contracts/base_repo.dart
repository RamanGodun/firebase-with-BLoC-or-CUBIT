import '../../base_modules/errors_handling/either/either.dart';
import '../../base_modules/errors_handling/failures/failure_entity.dart';
import '../../base_modules/errors_handling/utils/exceptions_to_failures_mapper/_exceptions_to_failures_mapper.dart';
import '../../base_modules/errors_handling/utils/for_riverpod/failure_utils.dart';
import '../../base_modules/errors_handling/utils/observers/loggers/errors_log_util.dart';

/// 🧩 [BaseRepository] — Common abstraction for handling safe async calls.
/// ✅ Eliminates boilerplate try-catch in concrete repositories
/// ✅ Centralizes FailureMapper + optional post-processing

base class BaseRepository {
  //----------------------
  const BaseRepository();
  //

  /// ⚙️ Wraps an async operation in try-catch and maps exceptions to [Failure]
  Future<Either<Failure, T>> executeSafely<T>(
    Future<T> Function() operation,
  ) async {
    try {
      final result = await operation();
      return Right(result);
    } catch (e, stackTrace) {
      return Left(ExceptionToFailureMapper.from(e, stackTrace));
    }
  }

  /// Usage:
  /// ```dart
  /// return safeCall(() => api.getUser());
  /// ```

  ////

  /// ⚙️ Same as [executeSafely] but for `void` returning operations
  Future<Either<Failure, void>> executeSafelyVoid(
    Future<void> Function() operation,
  ) async {
    try {
      await operation();
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ExceptionToFailureMapper.from(e, stackTrace));
    }
  }

  //
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
  Future<Either<Failure, T>> executeWithFailureHandling() async {
    try {
      final result = await this();
      return right(result);
    } catch (e, st) {
      ErrorsLogger.log(e, st);
      return left(mapToFailure(e, st));
    }
  }
}
