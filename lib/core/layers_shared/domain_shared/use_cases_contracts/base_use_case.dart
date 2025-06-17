import '../../../utils_shared/typedef.dart';

/// 🔧 [BaseUseCaseWithoutParams] — Base contract for use cases without parameters
/// ✅ Used for actions that require no input (e.g. GetCurrentUser)
//----------------------------------------------------------------
abstract class BaseUseCaseWithoutParams<T> {
  const BaseUseCaseWithoutParams();

  /// Executes the use case
  ResultFuture<T> call();
}

/// 🔧 [BaseUseCaseWithParams] — Base contract for use cases with input parameters
/// ✅ Flexible template for business logic that requires arguments
//----------------------------------------------------------------
abstract class BaseUseCaseWithParams<T, Params> {
  const BaseUseCaseWithParams();

  /// Executes the use case with given [params]
  ResultFuture<T> call(Params params);
}

// ----------------------------------------

/*
? or this option, that's is more flexible (for many errors types), when project grows
abstract class UseCaseWithoutParams<T, F extends Failure> {
  const UseCaseWithoutParams();

  Future<Either<F, T>> call();
}

abstract class UseCaseWithParams<T, Params, F extends Failure> {
  const UseCaseWithParams();

  Future<Either<F, T>> call(Params params);
}
 */
