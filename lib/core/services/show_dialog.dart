import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/text_widget.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/errors_handling/failures/extensions/_failure_x_imports.dart';

import '../constants/app_strings.dart';
import '../shared_modules/errors_handling/failures/failure.dart';

/// 🔌 [IShowDialog] — abstraction for displaying platform dialogs.
/// 🧼 Enables mocking, testing, and platform-specific implementations.
abstract interface class IShowDialog {
  ///
  void alertOnError(
    BuildContext context,
    Failure failure, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  });
}

/// 🧱 [MaterialDialogService] — Default material dialog implementation for errors.
/// Uses [AlertDialog] and [TextWidget] with unified theming & platform support.
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
            title: TextWidget(
              title ?? AppStrings.errorDialogTitle,
              TextType.titleMedium,
            ),
            content: TextWidget(failure.uiMessage, TextType.error),
            actions: [
              TextButton(
                onPressed: () {
                  context.popView();
                  onClose?.call();
                },
                child: TextWidget(
                  buttonText ?? AppStrings.okButton,
                  TextType.titleSmall,
                ),
              ),
            ],
          ),
    );
  }
}
