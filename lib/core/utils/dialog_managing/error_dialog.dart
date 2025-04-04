import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../widgets/mini_widgets.dart';
import '../../domain/models/custom_error.dart';

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
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
        );
  }
}

class ErrorDialog extends StatelessWidget {
  final String errorMessage;

  const ErrorDialog({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: AppMiniWidgets(MWType.error, error: errorMessage),
    );
  }

  // Method to show the dialog.
  static void show(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(errorMessage: errorMessage);
      },
    );
  }
}
