import 'package:firebase_with_bloc_or_cubit/core/presentation/shared_widgets/text_widget.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/extensions/on_failure/_failure_x_imports.dart';
import 'package:flutter/material.dart';

import '../shared_modules/errors_handling/failure.dart';

/// 🔌 [IShowDialog] — abstraction for platform/dialog services
/// 🧼 Enables testing and platform-specific implementations.
abstract interface class IShowDialog {
  void alertOnError(
    BuildContext context,
    Failure failure, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  });
}

class MaterialDialogService implements IShowDialog {
  const MaterialDialogService();

  @override
  void alertOnError(
    BuildContext context,
    Failure failure, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: TextWidget(title ?? 'Oops...', TextType.titleMedium),
            content: TextWidget(failure.uiMessage, TextType.error),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onClose?.call();
                },
                child: TextWidget(buttonText ?? 'OK', TextType.titleSmall),
              ),
            ],
          ),
    );
  }
}
