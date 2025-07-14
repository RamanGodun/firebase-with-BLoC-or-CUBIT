part of 'either.dart';

/// 📦 [Left] — Represents failure value of [Either]
@immutable
final class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;
}

////

////

/// 📦 [Right] — Represents success value of [Either]
@immutable
final class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;
}
