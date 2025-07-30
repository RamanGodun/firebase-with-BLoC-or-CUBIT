import '../../failures/failure__entity.dart';
import '../exceptions_to_failures_mapper/_exceptions_to_failures_mapper.dart';
import '../../either/either.dart';

/// 🧰 [FailureUtils] — shortcut helpers for converting errors into [Failure]s.
/// ✅ Acts as a single entry point for mapping errors and creating `Either`
/// ✅ Used in ResultFuture, UseCases, and async flows

Failure mapToFailure(dynamic error, [StackTrace? stack]) =>
    ExceptionToFailureMapper.from(error, stack);

////

////

/// ✅ [right] — helper for creating successful result in `Either` monad
Right<Failure, T> right<T>(T value) => Right(value);

////

////

/// ❌ [left] — helper for wrapping a [Failure] into an `Either.left`
Left<Failure, T> left<T>(Failure failure) => Left(failure);
