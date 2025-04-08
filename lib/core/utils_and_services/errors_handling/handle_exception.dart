import 'package:firebase_auth/firebase_auth.dart';
import 'custom_error.dart';

/// Handles exceptions and converts them into a structured [CustomError].
///
/// This function catches different types of Firebase-related exceptions
/// and converts them into a custom error format for better error handling
/// and debugging.
///
/// - [FirebaseAuthException] - Catches authentication-related errors.
/// - [FirebaseException] - Handles general Firebase-related errors.
/// - [Exception] - Catches any other unknown errors and provides a generic response.
///
/// Returns a [CustomError] containing the error details.
CustomError handleException(e) {
  try {
    throw e;
  }
  // Handle authentication-specific errors
  on FirebaseAuthException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Invalid credential',
      plugin: e.plugin,
    );
  }
  // Handle other Firebase-related exceptions
  on FirebaseException catch (e) {
    return CustomError(
      code: e.code,
      message: e.message ?? 'Firebase Error',
      plugin: e.plugin,
    );
  }
  // Handle any other unexpected errors
  catch (e) {
    return CustomError(
      code: 'Exception',
      message: e.toString(),
      plugin: 'Unknown error',
    );
  }
}
