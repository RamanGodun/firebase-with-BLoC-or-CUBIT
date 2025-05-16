import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../shared_presentation/constants/_app_constants.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../overlay_presets/preset_props.dart';
import '../../../animation_engines/__animation_engine_interface.dart';

/// 🤖 [AndroidAppDialog] — Animated Material-style dialog for Android
/// - Handles fallback dismiss by [isFromUserFlow] flag
///----------------------------------------------------------------------------

final class AndroidAppDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresetProps? presetProps;
  final bool isInfoDialog;
  final bool isFromUserFlow;
  final IAnimationEngine engine;
  final VoidCallback onAnimatedDismiss;

  const AndroidAppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
    required this.presetProps,
    required this.isInfoDialog,
    required this.isFromUserFlow,
    required this.engine,
    required this.onAnimatedDismiss,
  });

  /// 🔁 Handler for cancel button (with fallback)
  VoidCallback get _handleCancel => onCancel ?? onAnimatedDismiss;

  /// 🔁 Handler for confirm button (with fallback)
  VoidCallback get _handleConfirm => onConfirm ?? onAnimatedDismiss;

  @override
  Widget build(BuildContext context) {
    final icon = presetProps?.icon;
    final shape = presetProps?.shape;
    final backgroundColor = presetProps?.color;

    return FadeTransition(
      opacity: engine.opacity,
      child: ScaleTransition(
        scale: engine.scale,
        child: AlertDialog(
          shape: shape,
          backgroundColor: backgroundColor,
          title: Row(
            children: [
              if (icon != null) Icon(icon, size: 24),
              if (icon != null) const SizedBox(width: 8),
              TextWidget(title, TextType.titleMedium),
            ],
          ),
          content: TextWidget(content, TextType.bodyLarge),
          actions:
              isInfoDialog
                  ? [
                    TextButton(
                      onPressed: _handleConfirm,
                      child: Text(confirmText),
                    ),
                  ]
                  : [
                    TextButton(
                      onPressed: _handleCancel,
                      child: Text(cancelText),
                    ),
                    TextButton(
                      onPressed: _handleConfirm,
                      child: Text(confirmText),
                    ),
                  ],
        ),
      ),
    );
  }

  //
}

///

/// 🍎 [IOSAppDialog] — Animated glass-style Cupertino dialog for iOS/macOS
/// - Handles fallback dismiss by [isFromUserFlow] flag
//----------------------------------------------------------------------------

final class IOSAppDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresetProps? presetProps;
  final bool isInfoDialog;
  final bool isFromUserFlow;
  final IAnimationEngine engine;
  final VoidCallback onAnimatedDismiss;

  const IOSAppDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    required this.onCancel,
    required this.presetProps,
    required this.isInfoDialog,
    required this.isFromUserFlow,
    required this.engine,
    required this.onAnimatedDismiss,
  });

  /// ➟ Cancel action handler
  VoidCallback get _handleCancel => onCancel ?? onAnimatedDismiss;

  /// ➟ Confirm action handler
  VoidCallback get _handleConfirm => onConfirm ?? onAnimatedDismiss;

  @override
  Widget build(BuildContext context) {
    final icon = presetProps?.icon;
    final backgroundColor = presetProps?.color;

    return FadeTransition(
      opacity: engine.opacity,
      child: ScaleTransition(
        scale: engine.scale,
        child: CupertinoAlertDialog(
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
          content: TextWidget(content, TextType.bodyLarge),
          actions:
              isInfoDialog
                  ? [
                    CupertinoDialogAction(
                      onPressed: _handleConfirm,
                      isDefaultAction: true,
                      child: Text(confirmText),
                    ),
                  ]
                  : [
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
        ),
      ),
    );
  }
}
