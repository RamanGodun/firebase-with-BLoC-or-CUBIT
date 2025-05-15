import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../app_config/bootstrap/di_container.dart';
import '../../../../shared_presentation/constants/_app_constants.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../core/overlay_dispatcher/overlay_dispatcher_interface.dart';
import '../overlay_presets/preset_props.dart';

/// 🧱 [AppDialog] — Platform-adaptive dialog widget
/// - Renders [CupertinoAlertDialog] on iOS/macOS
/// - Renders [AlertDialog] on Android and others
/// - Used by [DialogOverlayEntry] as the final UI layer
///----------------------------------------------------------------------------

class AppDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresetProps? presetProps; // 🎨 Styling preset
  final TargetPlatform platform;
  final bool isInfoDialog;

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
    this.isInfoDialog = false,
  });

  /// 🧩 Fallback callback that dismisses current overlay
  VoidCallback get _fallbackDismiss =>
      () => di<IOverlayDispatcher>().dismissCurrent();

  /// 🔁 Handler for cancel button (with fallback)
  VoidCallback get _handleCancel => onCancel ?? _fallbackDismiss;

  /// 🔁 Handler for confirm button (with fallback)
  VoidCallback get _handleConfirm => onConfirm ?? _fallbackDismiss;

  ///
  @override
  Widget build(BuildContext context) {
    final icon = presetProps?.icon;
    final shape = presetProps?.shape;
    final backgroundColor = presetProps?.color;

    // 🍎 iOS/macOS: Native-styled Cupertino dialog
    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return CupertinoAlertDialog(
        title:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(title, TextType.titleMedium),
                if (icon != null)
                  Icon(
                    icon,
                    size: 28,
                    color: backgroundColor ?? AppColors.forErrors,
                  ),
                if (icon != null) const SizedBox(height: 15),
              ],
            ).centered(),
        content: TextWidget(
          content,
          TextType.bodyMedium,
          isTextOnFewStrings: true,
        ),
        actions: [
          if (isInfoDialog)
            CupertinoDialogAction(
              onPressed: _handleConfirm,
              isDefaultAction: true,
              child: Text(confirmText),
            )
          else ...[
            CupertinoDialogAction(
              onPressed: _handleCancel,
              child: Text(cancelText),
            ),
            CupertinoDialogAction(
              onPressed: _handleConfirm,
              isDefaultAction: true,
              child: Text(confirmText),
            ),
          ],
        ],
      );
    }

    // 🤖 Android/others: Material-styled dialog
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
      actions:
          isInfoDialog
              ? [
                TextButton(onPressed: _handleConfirm, child: Text(confirmText)),
              ]
              : [
                TextButton(onPressed: _handleCancel, child: Text(cancelText)),
                TextButton(onPressed: _handleConfirm, child: Text(confirmText)),
              ],
    );
  }
}
