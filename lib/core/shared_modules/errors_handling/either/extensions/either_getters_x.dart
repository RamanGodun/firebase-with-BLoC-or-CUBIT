part of '_either_x_imports.dart';

/// ✅ [EitherGetters] — lightweight accessors for test/debug/logic
//-------------------------------------------------------------------------
extension EitherGetters<L, R> on Either<L, R> {
  /// ❌ Returns Left value if exists, else null
  L? get leftOrNull => switch (this) {
    Left(:final value) => value,
    Right() => null,
  };

  /// ✅ Returns Right value if exists, else null
  R? get rightOrNull => switch (this) {
    Right(:final value) => value as R?,
    Left() => null,
  };
}
