import '../failure__entity.dart';

/// 🧠 [FailureRetryX] — extension that defines whether [Failure] is retryable
/// ✅ Used by UI logic to decide if "Retry" should be shown to the user
//
extension FailureRetryX on Failure {
  /// 🔁 Returns `true` if the failure is transient and user can retry the operation
  /// - Includes network errors, timeouts, and potentially temporary conditions
  bool get isRetryable => switch (this) {
    NetworkFailure() => true,
    TimeoutFailure() => true,
    _ => false,
  };

  //
}
