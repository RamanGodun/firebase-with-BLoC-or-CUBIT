import '../../../../core/utils/typedef.dart';

/// 🔧 [UseCaseWithoutParams] — Base contract for use cases without parameters
/// ✅ Used for actions that require no input (e.g. GetCurrentUser)
//----------------------------------------------------------------

abstract class UseCaseWithoutParams<T> {
  const UseCaseWithoutParams();

  /// Executes the use case
  ResultFuture<T> call();
}

/// 🔧 [UseCaseWithParams] — Base contract for use cases with input parameters
/// ✅ Flexible template for business logic that requires arguments
//----------------------------------------------------------------
abstract class UseCaseWithParams<T, Params> {
  const UseCaseWithParams();

  /// Executes the use case with given [params]
  ResultFuture<T> call(Params params);

  ///
}
