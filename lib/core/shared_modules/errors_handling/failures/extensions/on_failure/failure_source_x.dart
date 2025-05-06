part of '_failure_x_imports.dart';

/// 🧭 [FailureSourceX] — provides source info and type checkers for [Failure].
/// ✅ Includes plugin origin string (used in logging, analytics, crash reports)
/// ✅ Type checkers simplify UI conditionals and logical branching
//-----------------------------------------------------------------------------

extension FailureSourceX on Failure {
  //
  /// 🔌 Plugin or source origin of this [Failure] (e.g. Firebase, API, etc.)
  /// Used in logs and diagnostics to trace the origin of the error.
  String get pluginSource => switch (this) {
    GenericFailure() => statusCode?.toString() ?? ErrorPlugin.unknown.code,
    ApiFailure() => ErrorPlugin.httpClient.code,
    FirebaseFailure() => ErrorPlugin.firebase.code,
    UseCaseFailure() => ErrorPlugin.useCase.code,
    _ => ErrorPlugin.unknown.code,
  };

  /// 🔍 True if this is a network-related failure (e.g. no internet, timeout)
  bool get isNetworkFailure => pluginSource == ErrorPlugin.httpClient.code;

  /// 🔥 True if this is a Firebase-related failure
  bool get isFirebaseFailure => this is FirebaseFailure;

  /// ❓ True if this is an unknown/unexpected failure
  bool get isUnknown => this is UnknownFailure;

  ///
}
