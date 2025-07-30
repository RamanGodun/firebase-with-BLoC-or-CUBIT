part of 'plugins.dart';

/// 🗝️ [FailureKeys] — Localizable error keys for [Failure]
/// 🧩 Used with i18n and [AppLocalizer] to resolve messages
/// 📌 Grouped by source or domain of the failure
//
enum FailureKeys {
  //
  // 🌐 Network-related failures
  networkNoConnection, // 🌐 No internet / offline
  networkTimeout, // ⏳ Request timeout

  // 🔐 Auth-related / unauthorized access
  unauthorized, // 🔐 401 or invalid session

  //
  // 🔥 Firebase-specific failures
  firebaseDocMissing, // 📄 Firestore doc invalid or missing
  firebaseEmailInUse, // 📧 Email already registered
  firebaseGeneric, // 🔥 Generic Firebase error
  firebaseInvalidCredential, // ❌ Wrong login/password
  firebaseInvalidEmail, // 📬 Email format is invalid
  firebaseMissingEmail, // 📭 Email is empty or null
  firebaseNoCurrentUser, // 🚫 FirebaseAuth.currentUser == null
  firebaseOperationNotAllowed, // ❌ Disabled in Firebase console
  firebaseRequiresRecentLogin, // 🔐 Needs re-authentication
  firebaseTooManyRequests, // 🧨 Throttled / IP blocked
  firebaseUserDisabled, // 🚫 Account banned or deactivated
  firebaseUserNotFound, // 👤 Email not registered
  firebaseWeakPassword, // 🧵 Password is too simple
  firebaseWrongPassword, // 🔑 Valid email, wrong password

  // 📧 Email verification specific failure
  emailVerificationTimeout, // 🕓 Timeout during email polling

  // ⏱️ General app-level timeout
  timeout, // ⌛ Generic request timeout

  //
  // 📦 Internal app/data format issues
  formatError, // 🧩 JSON parsing or data format error

  // ❓ Fallbacks or rare plugin-related issues
  unknown, // ❓ Unexpected or unclassified error
  missingPlugin; // 🧩 Platform plugin not available

  ////
  ////

  /// 🌐 Maps each key to its corresponding translation ID
  /// Used by [AppLocalizer] to provide i18n support for UI
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

    emailVerificationTimeout => 'failure.email_verification.timeout',

    timeout => 'failure.timeout',

    formatError => 'failure.format.error',
    unknown => 'failure.unknown',
    missingPlugin => 'failure.plugin.missing',
  };

  //
}
