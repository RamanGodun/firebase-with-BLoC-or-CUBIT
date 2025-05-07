library;

/// 🔌 [ErrorPlugin] — Identifies the source of a [CustomError].
/// 🧭 Useful for analytics, diagnostics, and categorizing error origins.
//-------------------------------------------------------------------------

enum ErrorPlugin {
  httpClient,
  firebase,
  sqlite,
  useCase,
  unknown;

  String get code => switch (this) {
    httpClient => 'HTTP_CLIENT',
    firebase => 'FIREBASE',
    sqlite => 'SQLITE',
    useCase => 'USE_CASE',
    unknown => 'UNKNOWN',
  };

  ///
}
