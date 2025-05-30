import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/either_for_data/either_x/either_getters_x.dart';
import '../../errors_handling/failures_for_domain_and_presentation/failure_for_domain.dart';
import '../../errors_handling/either_for_data/either.dart';

/// 🚦 [ResultNavigationExt] — Provides `.redirectIfSuccess()` for sync and async results
/// ✅ Helps trigger side effects like navigation in success flow
//-------------------------------------------------------------------------

extension ResultNavigationExt<T> on Either<Failure, T> {
  /// 🔁 Runs callback if result is success (e.g. for redirect/navigation)
  Either<Failure, T> redirectIfSuccess(void Function(T value) navigator) {
    final value = rightOrNull;
    if (value != null) navigator(value);
    return this;
  }
}

extension ResultFutureNavigationExt<T> on Future<Either<Failure, T>> {
  /// 🔁 Awaits result and runs [navigator] if success
  Future<Either<Failure, T>> redirectIfSuccess(
    FutureOr<void> Function(T value) navigator,
  ) async {
    final result = await this;
    final value = result.rightOrNull;
    if (value != null) await navigator(value);
    return result;
  }
}
