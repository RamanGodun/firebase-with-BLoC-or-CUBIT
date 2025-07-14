part 'failure_key.dart';

/// 🔌 [ErrorPlugins] — Identifies the source of a [CustomError].
/// 🧭 Useful for analytics, diagnostics, and categorizing error origins.

enum ErrorPlugins {
  //-------------

  httpClient,
  firebase,
  sqlite,
  useCase,
  emailVerification,
  unknown;

  /// 📦 Code used in logs and telemetry (e.g. 'FIREBASE')
  String get code => switch (this) {
    httpClient => 'HTTP_CLIENT',
    firebase => 'FIREBASE',
    sqlite => 'SQLITE',
    useCase => 'USE_CASE',
    emailVerification => 'EMAIL_VERIFICATION',
    unknown => 'UNKNOWN',
  };

  //
}
