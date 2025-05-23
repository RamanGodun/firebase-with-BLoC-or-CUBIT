import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either_for_data/either_x/_eithers_facade.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/loggers_for_errors_handling_module/failure_diagnostics_x.dart';
import '../../failures_for_domain_and_presentation/failure_for_domain.dart';

/// 🧪 [ResultFutureTestX] — Fluent test helpers for async Either
//-------------------------------------------------------------------------

extension ResultFutureTestX<T> on Future<Either<Failure, T>> {
  /// ✅ Expect that future resolves to Right with [expected] value
  Future<void> expectSuccess(T expected) async {
    final result = await this;
    assert(
      result.isRight,
      'Expected Right but got Left: \${result.leftOrNull}',
    );
    assert(
      result.rightOrNull == expected,
      'Expected value \$expected but got \${result.rightOrNull}',
    );
  }

  /// ✅ Expect that future resolves to Left (optionally matching [code])
  Future<void> expectFailure([String? code]) async {
    final result = await this;
    assert(
      result.isLeft,
      'Expected Left but got Right: \${result.rightOrNull}',
    );
    if (code != null) {
      assert(
        result.leftOrNull?.safeCode == code,
        'Expected failure code \$code but got \${result.leftOrNull?.safeCode}',
      );
    }
  }
}
