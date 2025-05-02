// import 'package:firebase_auth/firebase_auth.dart';
// import 'custom_error.dart';

// /// 🧩 Converts all exceptions into a unified [CustomError] structure.
// /// ✅ Use in [catch] blocks to ensure consistent error formatting across the app.
// /// Handles:
// ///    - [FirebaseAuthException] – for auth-specific issues.
// ///    - [FirebaseException] – for general Firebase service errors.
// ///    - [Exception] – fallback for any other runtime exceptions.

// CustomError handleException(dynamic exception) {
//   try {
//     throw exception;
//   } on FirebaseAuthException catch (e) {
//     return CustomError(
//       code: e.code,
//       message: e.message ?? 'Invalid credentials',
//       plugin: e.plugin,
//     );
//   } on FirebaseException catch (e) {
//     return CustomError(
//       code: e.code,
//       message: e.message ?? 'Firebase error',
//       plugin: e.plugin,
//     );
//   } catch (e) {
//     return CustomError(
//       code: 'unknown_exception',
//       message: e.toString(),
//       plugin: 'flutter_error/server_error',
//     );
//   }
// }
