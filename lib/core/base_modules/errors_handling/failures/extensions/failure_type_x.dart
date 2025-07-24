import '../failure_entity.dart';

/// 🧭 [FailureTypeX] — Semantic helpers for `Failure` type branching
/// ✅ Replaces `is SomeFailure` with readable intent
/// ✅ Improves clarity in conditional logic (UI/logic branching)
//
extension FailureTypeX on Failure {
  ///───────────────────────────

  /// ❌ True if failure is due to lack of network or timeout
  bool get isNetwork => this is NetworkFailure;

  /// 🔒 True if failure was caused by unauthorized access (401)
  bool get isUnauthorized => this is UnauthorizedFailure;

  /// 🔥 True if failure originated from Firebase layer
  bool get isFirebase => this is FirebaseFailure;

  /// 💾 True if failure is from local cache or preferences
  bool get isCache => this is CacheFailure;

  /// 🌐 True if failure is HTTP-level (non-auth)
  bool get isApi => this is ApiFailure;

  /// ❓ True if failure is uncategorized or fallback
  bool get isUnknown => this is UnknownFailure;

  /// ⚙️ True if failure was caused by a plugin/platform system issue
  bool get isPlatform => this is GenericFailure;

  /// 🧠 True if failure occurred in business/use-case logic
  bool get isUseCase => this is UseCaseFailure;

  //
}
