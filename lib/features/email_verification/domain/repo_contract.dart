import '../../../core/utils_shared/typedef.dart';

/// 🧼 Contract for email verification and user reload operations
//
abstract interface class IUserValidationRepo {
  ///-----------------------------------------
  //
  // 📧 Sends verification email to current user
  ResultFuture<void> sendEmailVerification();

  // 🔁 Reloads the current user's state from Firebase
  ResultFuture<void> reloadUser();

  // ✅ Checks if the user's email is verified
  ResultFuture<bool> isEmailVerified();

  //
}
