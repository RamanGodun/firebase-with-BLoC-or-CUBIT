import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../models/models_with_code_gen_from_other/custom_error.dart';
import '../helper.dart' show Helpers;

class ErrorHandling {
  static void showErrorDialog(BuildContext context, CustomError e) {
    final isIOS =
        defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS;

    isIOS
        ? showCupertinoDialog(
          context: context,
          builder:
              (context) => CupertinoAlertDialog(
                title: Text(e.code),
                content: Text('plugin: ${e.plugin}\n\n${e.message}'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
        )
        : showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text(e.code),
                content: Text('plugin: ${e.plugin}\n\n${e.message}'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Helpers.pop(context),
                  ),
                ],
              ),
        );
  }
}
