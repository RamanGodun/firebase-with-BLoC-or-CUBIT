import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';

/// 🪟 [PlatformDialogWidget] — Custom reusable dialog widget for overlay system
class PlatformDialogWidget extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  const PlatformDialogWidget({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextWidget(title, TextType.titleMedium),
      content: TextWidget(content, TextType.bodyMedium),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            onCancel?.call();
          },
          child: TextWidget(cancelText, TextType.labelLarge),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
            onConfirm?.call();
          },
          child: TextWidget(confirmText, TextType.labelLarge),
        ),
      ],
    );
  }
}
