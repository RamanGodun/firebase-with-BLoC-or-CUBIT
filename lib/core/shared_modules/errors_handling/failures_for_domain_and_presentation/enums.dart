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

enum FailureKey {
  networkNoConnection,
  networkTimeout,
  unauthorized,
  firebaseGeneric,
  formatError,
  unknown,
  missingPlugin
  // інші кейси...
  ;

  String get translationKey => switch (this) {
    networkNoConnection => 'failure.network.no_connection',
    networkTimeout => 'failure.network.timeout',
    unauthorized => 'failure.auth.unauthorized',
    firebaseGeneric => 'failure.firebase.generic',
    formatError => 'failure.format.error',
    unknown => 'failure.unknown',
    missingPlugin => 'failure.plugin.missing',
  };
}
