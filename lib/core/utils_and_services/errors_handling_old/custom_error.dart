// import 'package:flutter/foundation.dart';

// /// *🧩[CustomError] — unified error model used across the app, contains:
// ///       - [code]: Firestore/Auth error code
// ///       - [message]: Human-readable error message
// ///       - [plugin]: Source of the error (e.g. `firebase_auth`, `cloud_firestore`)
// @immutable
// class CustomError {
//   final String code;
//   final String message;
//   final String plugin;

//   const CustomError({this.code = '', this.message = '', this.plugin = ''});

//   /// 🔁 Creates a modified copy of the current error
//   CustomError copyWith({String? code, String? message, String? plugin}) {
//     return CustomError(
//       code: code ?? this.code,
//       message: message ?? this.message,
//       plugin: plugin ?? this.plugin,
//     );
//   }

//   @override
//   String toString() =>
//       'CustomError(code: $code, message: $message, plugin: $plugin)';

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is CustomError &&
//           runtimeType == other.runtimeType &&
//           code == other.code &&
//           message == other.message &&
//           plugin == other.plugin;

//   @override
//   int get hashCode => Object.hash(code, message, plugin);
// }
