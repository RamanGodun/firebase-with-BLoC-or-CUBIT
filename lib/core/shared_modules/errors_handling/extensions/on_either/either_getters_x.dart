part of '_either_x_imports.dart';

/// ✅ [EitherGetters] — lightweight accessors for test/debug/logic
extension EitherGetters<L, R> on Either<L, R> {
  L? get leftOrNull => switch (this) {
    Left(:final value) => value,
    Right() => null,
  };

  R? get rightOrNull => switch (this) {
    Right(:final value) => value as R?,
    Left() => null,
  };
}
