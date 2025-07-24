import '../../enums/error_plugins.dart';
import '../failure_entity.dart';

/// 🧭 [FailureDiagnosticsX] — Diagnostic utilities for `Failure`
/// ✅ Includes type checkers, casting, logging helpers, and fallback-safe metadata access.
/// ✅ Used in logging, Crashlytics, result handlers, and advanced failure branching.
//
extension FailureDiagnosticsX on Failure {
  /// ─────────────────────────────────

  /// 🔌 Source & Type Diagnostics
  /// Returns plugin source identifier (used in logs, analytics, crash reports)
  String get pluginSource => switch (this) {
    GenericFailure() => statusCode?.toString() ?? ErrorPlugins.unknown.code,
    ApiFailure() => ErrorPlugins.httpClient.code,
    FirebaseFailure() => ErrorPlugins.firebase.code,
    UseCaseFailure() => ErrorPlugins.useCase.code,
    UnauthorizedFailure() => 'AUTH',
    CacheFailure() => 'CACHE',
    _ => ErrorPlugins.unknown.code,
  };

  /// True if failure is related to network (e.g. no internet, timeout)
  bool get isNetworkFailure => pluginSource == ErrorPlugins.httpClient.code;

  /// True if failure originated from Firebase
  bool get isFirebaseFailure => this is FirebaseFailure;

  /// True if failure indicates unauthenticated access (401, expired token)
  bool get isUnauthorized => this is UnauthorizedFailure;

  /// True if failure is related to cache/storage layer
  bool get isCacheFailure => this is CacheFailure;

  /// True if failure is a fallback for unknown/unhandled exceptions
  bool get isUnknown => this is UnknownFailure;

  ///
  // 🔁 Runtime Casting & Metadata

  /// Safe type-cast of the current failure to a specific subtype
  T? as<T extends Failure>() => this is T ? this as T : null;

  /// Returns non-null error code (for logs, identifiers)
  String get safeCode => code ?? 'UNKNOWN_CODE';

  /// Returns stringified status (e.g. HTTP or plugin code)
  String get safeStatus => statusCode?.toString() ?? 'NO_STATUS';

  /// Developer-friendly label combining code and message
  String get label => '$safeCode — $message';

  //
}
