part of '_failure_x_imports.dart';

/// 🔌🧭 [FailureSourceX] — provides failure origin (plugin/source code) for diagnostics/logging.
extension FailureSourceX on Failure {
  /// Returns a standardized origin source string (for logging/analytics)
  String get pluginSource => switch (this) {
    GenericFailure(:final error) => error.plugin.code,
    ApiFailure() => ErrorPlugin.httpClient.code,
    FirebaseFailure() => ErrorPlugin.firebase.code,
    UseCaseFailure() => ErrorPlugin.useCase.code,
    _ => ErrorPlugin.unknown.code,
  };
}
