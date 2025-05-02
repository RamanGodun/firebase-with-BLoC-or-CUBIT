// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// import '../helpers.dart' show Helpers;
// import 'custom_error.dart';

// /// 🧩 [AppDialogs] — utility class to show platform-specific dialogs.
// class AppDialogs {
//   /// ❌ Displays an error dialog (Cupertino or Material) based on platform.
//   static void showErrorDialog(BuildContext context, CustomError error) {
//     final isCupertino =
//         defaultTargetPlatform == TargetPlatform.iOS ||
//         defaultTargetPlatform == TargetPlatform.macOS;

//     final title = Text(error.code);
//     final content = Text('plugin: ${error.plugin}\n\n${error.message}');
//     final okActionText = const Text('OK');

//     if (isCupertino) {
//       showCupertinoDialog<void>(
//         context: context,
//         builder:
//             (_) => CupertinoAlertDialog(
//               title: title,
//               content: content,
//               actions: [
//                 CupertinoDialogAction(
//                   onPressed: () => Navigator.pop(context),
//                   child: okActionText,
//                 ),
//               ],
//             ),
//       );
//     } else {
//       showDialog<void>(
//         context: context,
//         builder:
//             (_) => AlertDialog(
//               title: title,
//               content: content,
//               actions: [
//                 TextButton(
//                   onPressed: () => Helpers.pop(context),
//                   child: okActionText,
//                 ),
//               ],
//             ),
//       );
//     }
//   }
// }
