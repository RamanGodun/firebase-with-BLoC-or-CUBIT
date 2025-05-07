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
