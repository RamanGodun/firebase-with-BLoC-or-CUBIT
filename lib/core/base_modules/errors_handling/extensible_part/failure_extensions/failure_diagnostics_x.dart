import '../../core_of_module/failure_entity.dart';
import '../failure_types/_failure_codes.dart';

/// 🧭 [FailureX] — Unified extensions for [Failure]
/// ✅ Includes semantic type-checkers, diagnostics, casting, and safe metadata access
/// ✅ Used in conditional logic, logging, Crashlytics, result handlers, and UI mapping
//
extension FailureX on Failure {
  ///

  /// 🔍 SEMANTIC TYPE CHECKERS
  //────────────────────────--
  // ✅ Declarative failure-type checks for branching and logic

  bool get isNetworkFailure => type.code == FailureCodes.network;
  bool get isUnauthorizedFailure => type.code == FailureCodes.unauthorized;
  bool get isApiFailure => type.code == FailureCodes.api;
  bool get isUnknownFailure => type.code == FailureCodes.unknown;
  bool get isUseCaseFailure => type.code == FailureCodes.useCase;
  bool get isTimeoutFailure => type.code == FailureCodes.timeout;
  bool get isEmailVerificationFailure =>
      type.code == FailureCodes.emailVerification ||
      type.code == FailureCodes.emailVerificationTimeout;
  bool get isFirestoreDocMissingFailure =>
      type.code == FailureCodes.firestoreDocMissing;
  bool get isFirebaseUserMissingFailure =>
      type.code == FailureCodes.firebaseUserMissing;
  bool get isCacheFailure => type.code == FailureCodes.cache;
  bool get isFirebaseFailure => type.code == FailureCodes.firebase;
  bool get isFormatErrorFailure => type.code == FailureCodes.formatError;
  bool get isMissingPluginFailure => type.code == FailureCodes.missingPlugin;
  bool get isJsonErrorFailure => type.code == FailureCodes.jsonError;
  bool get isInvalidCredential => type.code == FailureCodes.invalidCredential;
  //

  /// 🔁 Casting & Metadata access
  //────────────────────────----

  /// Safe type-cast of the current failure to a specific subtype
  T? as<T extends Failure>() => this is T ? this as T : null;

  /// Non-null error code (e.g., for display, logs)
  String get safeCode => statusCode?.toString() ?? type.code;

  /// Optional numeric status (e.g. HTTP, plugin, etc.)
  String get safeStatus => statusCode?.toString() ?? 'NO_STATUS';

  /// Developer-friendly diagnostic label
  String get label => '$safeCode — ${message ?? "No message"}';

  //
}
