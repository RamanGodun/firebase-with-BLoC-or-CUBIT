import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../overlay_presets/preset_props.dart';
import '../../../animation_engines/__animation_engine_interface.dart';

/// 💬 [AndroidDialog] — Platform-aware Material dialog with animation
/// - Built for Android: uses [AlertDialog] + entrance animation via [IAnimationEngine]
/// - Triggered from overlay tasks or state dispatcher flows
/// - Handles fallback dismiss logic via [onAnimatedDismiss]
// -----------------------------------------------------------------------

final class AndroidDialog extends StatelessWidget {
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

  const AndroidDialog({
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

  /// 🧭 Resolves cancel action: fallback to [onAnimatedDismiss] if [onCancel] is null
  VoidCallback get _handleCancel => onCancel ?? onAnimatedDismiss;

  /// 🧭 Resolves confirm action: fallback to [onAnimatedDismiss] if [onConfirm] is null
  VoidCallback get _handleConfirm => onConfirm ?? onAnimatedDismiss;

  ///
  @override
  Widget build(BuildContext context) {
    final icon = presetProps?.icon;
    final shape = presetProps?.shape;
    final backgroundColor = presetProps?.color;

    /// 🧱 Animated dialog using fade + scale from [engine]
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

          /// 🎛️ One or two buttons depending on [isInfoDialog] flag
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
