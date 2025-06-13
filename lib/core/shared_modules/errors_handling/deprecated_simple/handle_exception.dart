// import 'package:firebase_auth/firebase_auth.dart';
// import 'custom_error.dart';

// /// 🧩 [handleException] — unified error formatter
// /// 🧼 Converts Firebase/native exceptions into [CustomError]
// //----------------------------------------------------------------//
// CustomError handleException(dynamic e) {
//   //
//   try {
//     throw e;
//   } on FirebaseAuthException catch (e) {
//     return CustomError(
//       code: e.code,
//       message: e.message ?? 'Invalid credential',
//       plugin: e.plugin,
//     );
//   } on FirebaseException catch (e) {
//     return CustomError(
//       code: e.code,
//       message: e.message ?? 'Firebase error occurred',
//       plugin: e.plugin,
//     );
//   } catch (e) {
//     return CustomError(
//       code: 'Exception',
//       message: e.toString(),
//       plugin: 'Unknown',
//     );
//   }
// }
