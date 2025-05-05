// 📦 core/shared_modules/errors_handling/either/either.dart

/// 🎯 [Either] — functional programming construct representing a value that can be [Left] (failure) or [Right] (success).
sealed class Either<L, R> {
  const Either();

  bool get isLeft => this is Left<L, R>;
  bool get isRight => this is Right<L, R>;

  T fold<T>(T Function(L l) leftOp, T Function(R r) rightOp) => switch (this) {
    Left(:final value) => leftOp(value),
    Right(:final value) => rightOp(value),
  };

  Either<L2, R2> map<L2, R2>(L2 Function(L l) mapL, R2 Function(R r) mapR) =>
      switch (this) {
        Left(:final value) => Left(mapL(value)),
        Right(:final value) => Right(mapR(value)),
      };

  Either<L, R2> mapRight<R2>(R2 Function(R r) mapR) => switch (this) {
    Left(:final value) => Left(value),
    Right(:final value) => Right(mapR(value)),
  };

  Either<L2, R> mapLeft<L2>(L2 Function(L l) mapL) => switch (this) {
    Left(:final value) => Left(mapL(value)),
    Right(:final value) => Right(value),
  };

  Either<L, R2> flatMap<R2>(Either<L, R2> Function(R r) mapR) => switch (this) {
    Left(:final value) => Left(value),
    Right(:final value) => mapR(value),
  };
}

/// 📦 [Left] — wrapper for failure value in [Either]
final class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;
}

/// 📦 [Right] — wrapper for success value in [Either]
final class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;
}


