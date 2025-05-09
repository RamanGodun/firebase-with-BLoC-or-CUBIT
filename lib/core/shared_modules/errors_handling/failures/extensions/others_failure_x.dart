part of '_failure_x_imports.dart';

/// 🧩 [FailureCastX] — runtime-safe casting for specific Failure types
/// ✅ Enables type-specific access with optional null fallback
//----------------------------------------------------------------------

extension FailureCastX on Failure {
  ///
  T? as<T extends Failure>() => this is T ? this as T : null;
}

/// 🧾 [FailureCodeX] — utilities for extracting or formatting `code`
/// ✅ Prevents null checks and enforces defaults
extension FailureCodeX on Failure {
  /// Returns safe non-null code or fallback
  String get safeCode => code ?? 'UNKNOWN_CODE';

  /// Returns stringified status code or fallback
  String get safeStatus => statusCode?.toString() ?? 'NO_STATUS';

  /// 🏷️ Combined dev-friendly label for logs (e.g. 'API_ERROR — No token')
  String get label => '$safeCode — $message';

  ///
}

/// Usage:
/// ```dart
/// final apiError = failure.as<ApiFailure>();
/// if (apiError != null) print(apiError.statusCode);
/// ```
