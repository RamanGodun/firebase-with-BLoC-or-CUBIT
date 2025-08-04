/// 🧾 [FailureCodes] — centralized string constants for all known failure codes
/// ✅ Used to avoid magic strings across diagnostics, icons, factories, conditions
//
sealed class FailureCodes {
  // ⚙️ Platform/plugin errors
  static const platform = 'PLATFORM';

  // 🌐 Network
  static const network = 'NETWORK';
  static const jsonError = 'JSON_ERROR';
  static const timeout = 'TIMEOUT';

  // 🔥 Firebase/Firestore/Auth
  static const firebase = 'FIREBASE';
  static const firebaseUserMissing = 'FIREBASE_USER_MISSING';
  static const firestoreDocMissing = 'FIRESTORE_DOC_MISSING';

  // Firebase/Auth-specific codes
  static const invalidCredential = 'INVALID_CREDENTIAL';
  static const accountExistsWithDifferentCredential =
      'ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL';
  static const emailAlreadyInUse = 'EMAIL_ALREADY_IN_USE';
  static const operationNotAllowed = 'OPERATION_NOT_ALLOWED';
  static const userDisabled = 'USER_DISABLED';
  static const userNotFound = 'USER_NOT_FOUND';
  static const requiresRecentLogin = 'REQUIRES_RECENT_LOGIN';
  static const tooManyRequests = 'TOO_MANY_REQUESTS';

  // 🕒 Email verification
  static const emailVerificationTimeout = 'EMAIL_VERIFICATION_TIMEOUT';
  static const emailVerification = 'EMAIL_VERIFICATION';

  // 🧊 SQLite / local DBs (not used yet)
  static const sqlite = 'SQLITE';

  // App-specific
  static const useCase = 'USE_CASE';
  static const cache = 'CACHE';
  static const formatError = 'FORMAT_ERROR';
  static const missingPlugin = 'MISSING_PLUGIN';
  static const api = 'API';
  static const noStatus = 'NO_STATUS';
  static const unknown = 'UNKNOWN';
  static const unauthorized = 'UNAUTHORIZED';
  static const unknownCode = 'UNKNOWN_CODE';

  //
}
