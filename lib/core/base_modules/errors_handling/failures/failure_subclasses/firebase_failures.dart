part of '../failure_entity.dart';

/// 🔥 [FirebaseFailure] — general firebase-related issues
//
final class FirebaseFailure extends Failure {
  ///---------------------------------------
  //
  FirebaseFailure({
    required super.message,
    FailureKeys translationKey = FailureKeys.firebaseGeneric,
  }) : super._(
         statusCode: ErrorPlugins.firebase.code,
         code: 'FIREBASE',
         translationKey: translationKey.translationKey,
       );
  //
}

////

/// ❌ [FirebaseUserMissingFailure] — FirebaseAuth.currentUser is null
//
final class FirebaseUserMissingFailure extends FirebaseFailure {
  ///---------------------------------------
  //
  FirebaseUserMissingFailure()
    : super(
        message: 'FirebaseAuth.currentUser is null. User not signed in.',
        translationKey: FailureKeys.firebaseGeneric,
      );
  //
}

////

/// 🔍 [FirestoreDocMissingFailure] — document exists but has wrong structure
//
final class FirestoreDocMissingFailure extends FirebaseFailure {
  ///---------------------------------------
  //
  FirestoreDocMissingFailure()
    : super(
        message: 'Expected document is missing in Firestore.',
        translationKey: FailureKeys.firebaseDocMissing,
      );
  //
}

////

final class EmailVerificationFailure extends Failure {
  ///--------------------------------------------

  EmailVerificationFailure.timeoutExceeded()
    : super._(
        message: 'Email verification polling timed out.',
        translationKey: FailureKeys.emailVerificationTimeout.translationKey,
        code: 'EMAIL_VERIFICATION_TIMEOUT',
        statusCode: ErrorPlugins.useCase.code,
      );

  //
}
