import '../../../modules_shared/errors_handling/either/either.dart';
import '../../../modules_shared/errors_handling/failures/failure_entity.dart';
import '../../../modules_shared/errors_handling/utils/exceptions_to_failures_mapper/_exceptions_to_failures_mapper.dart';

/// 🧩 [BaseRepository] — Common abstraction for handling safe async calls.
/// ✅ Eliminates boilerplate try-catch in concrete repositories
/// ✅ Centralizes FailureMapper + optional post-processing
//----------------------------------------------------------------
abstract class BaseRepository {
  const BaseRepository();

  /// ⚙️ Wraps an async operation in try-catch and maps exceptions to [Failure]
  /// Usage:
  /// ```dart
  /// return safeCall(() => api.getUser());
  /// ```
  Future<Either<Failure, T>> safeCall<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Right(result);
    } catch (e, stackTrace) {
      return Left(ExceptionToFailureMapper.from(e, stackTrace));
    }
  }

  /// ⚙️ Same as [safeCall] but for `void` returning operations
  /// Usage:
  /// ```dart
  /// return safeCallVoid(() => api.logOut());
  /// ```
  Future<Either<Failure, void>> safeCallVoid(
    Future<void> Function() operation,
  ) async {
    try {
      await operation();
      return const Right(null);
    } catch (e, stackTrace) {
      return Left(ExceptionToFailureMapper.from(e, stackTrace));
    }
  }
}
