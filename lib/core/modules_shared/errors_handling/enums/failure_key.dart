part of 'error_plugins.dart';

/// 🗝️ [FailureKeys] — Localizable error keys for [Failure]
/// 🧩 Used with i18n and [AppLocalizer] to resolve messages

enum FailureKeys {
  //
  networkNoConnection, // 🌐 No internet / offline
  networkTimeout, // ⏳ Request timeout
  unauthorized, // 🔐 401 or invalid session

  firebaseDocMissing, // 📄 Firestore doc invalid or missing
  firebaseEmailInUse, // 📧 Already registered
  firebaseGeneric, // 🔥 Generic Firebase error
  firebaseInvalidCredential, // ❌ Wrong login/password
  firebaseInvalidEmail, // 📬 Email format is invalid
  firebaseMissingEmail, // 📭 Email is empty or null
  firebaseNoCurrentUser, // 🚫 FirebaseAuth.currentUser == null
  firebaseOperationNotAllowed, // ❌ Disabled in Firebase console
  firebaseRequiresRecentLogin, // 🔐 Needs re-auth
  firebaseTooManyRequests, // 🧨 Throttled / IP blocked
  firebaseUserDisabled, // 🚫 Account banned or deactivated
  firebaseUserNotFound, // 👤 Email not registered
  firebaseWeakPassword, // 🧵 Too simple
  firebaseWrongPassword, // 🔑 Valid email, wrong password

  formatError, // 📦 JSON parsing or data format
  unknown, // ❓ Unexpected or unclassified
  missingPlugin; // 🧩 Platform plugin not available

  ///

  /// 🌐 Maps each key to translation ID for localization
  String get translationKey => switch (this) {
    //
    networkNoConnection => 'failure.network.no_connection',
    networkTimeout => 'failure.network.timeout',
    unauthorized => 'failure.auth.unauthorized',

    firebaseDocMissing => 'failure.firebase.doc_missing',
    firebaseEmailInUse => 'failure.firebase.email_in_use',
    firebaseGeneric => 'failure.firebase.generic',
    firebaseInvalidCredential => 'failure.firebase.invalid_credential',
    firebaseInvalidEmail => 'failure.firebase.invalid_email',
    firebaseMissingEmail => 'failure.firebase.missing_email',
    firebaseNoCurrentUser => 'failure.firebase.no_current_user',
    firebaseOperationNotAllowed => 'failure.firebase.operation_not_allowed',
    firebaseRequiresRecentLogin => 'failure.firebase.requires_recent_login',
    firebaseTooManyRequests => 'failure.firebase.too_many_requests',
    firebaseUserDisabled => 'failure.firebase.user_disabled',
    firebaseUserNotFound => 'failure.firebase.user_not_found',
    firebaseWeakPassword => 'failure.firebase.weak_password',
    firebaseWrongPassword => 'failure.firebase.wrong_password',

    formatError => 'failure.format.error',
    unknown => 'failure.unknown',
    missingPlugin => 'failure.plugin.missing',
  };
}
