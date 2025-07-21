import '../../either/either.dart';
import '../failure_entity.dart';

extension FailureToEitherX on Failure {
  /// ❌ Converts this [Failure] into an `Either.left`
  Left<Failure, T> toLeft<T>() => Left(this);
}
