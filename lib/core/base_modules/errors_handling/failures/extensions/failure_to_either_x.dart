import '../../either/either.dart';
import '../failure__entity.dart';

extension FailureToEitherX on Failure {
  /// ❌ Converts this [Failure] into an `Either.left`
  Left<Failure, T> toLeft<T>() => Left(this);
}
