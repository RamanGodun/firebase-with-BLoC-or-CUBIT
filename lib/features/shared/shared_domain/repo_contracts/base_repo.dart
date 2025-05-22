import '../../../../core/shared_modules/errors_handling/either_for_data/either.dart';
import '../../../../core/shared_modules/errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '../../../../core/shared_modules/errors_handling/utils/failure_mapper.dart';

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
      return Left(FailureMapper.from(e, stackTrace));
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
      return Left(FailureMapper.from(e, stackTrace));
    }
  }
}
