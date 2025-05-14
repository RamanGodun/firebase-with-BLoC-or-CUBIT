import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../shared_presentation/constants/_app_constants.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../overlay_presets/preset_props.dart';

/// 🧱 [AppDialog] — Stateless cross-platform dialog widget
/// ✅ Renders CupertinoAlertDialog for iOS/macOS, AlertDialog for Android/others

class AppDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresetProps? presetProps;
  final TargetPlatform platform;

  const AppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
    required this.presetProps,
    required this.platform,
  });

  @override
  Widget build(BuildContext context) {
    final icon = presetProps?.icon;
    final shape = presetProps?.shape;
    final backgroundColor = presetProps?.color;

    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return CupertinoAlertDialog(
        title:
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null)
                  Icon(
                    icon,
                    size: 28,
                    color: presetProps?.color ?? AppColors.forErrors,
                  ),
                if (icon != null) const SizedBox(height: 4),
                TextWidget(title, TextType.titleMedium),
              ],
            ).centered(),
        content: TextWidget(
          content,
          TextType.bodyMedium,
          isTextOnFewStrings: true,
        ),
        actions: [
          CupertinoDialogAction(onPressed: onCancel, child: Text(cancelText)),
          CupertinoDialogAction(
            onPressed: onConfirm,
            isDefaultAction: true,
            child: Text(confirmText),
          ),
        ],
      );
    }

    return AlertDialog(
      shape: shape,
      backgroundColor: backgroundColor,
      title: Row(
        children: [
          if (icon != null) Icon(icon, size: 24),
          if (icon != null) const SizedBox(width: 8),
          TextWidget(title, TextType.titleMedium),
        ],
      ),
      content: TextWidget(content, TextType.bodyMedium),
      actions: [
        TextButton(onPressed: onCancel, child: Text(cancelText)),
        TextButton(onPressed: onConfirm, child: Text(confirmText)),
      ],
    );
  }
}
