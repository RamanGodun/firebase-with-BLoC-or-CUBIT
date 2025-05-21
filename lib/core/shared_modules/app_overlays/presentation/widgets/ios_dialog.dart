import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/cupertino.dart';
import '../../../../app_config/bootstrap/di_container.dart';
import '../../../../shared_presentation/constants/_app_constants.dart';
import '../../../app_localization/code_base_for_both_options/text_widget.dart';
import '../../state_driven_flow/overlay_dispatcher/overlay_dispatcher_interface.dart';
import '../overlay_presets/preset_props.dart';
import '../../../app_animation/animation_engines/__animation_engine_interface.dart';

/// 🍎 [IOSAppDialog] — Animated glass-style Cupertino dialog for iOS/macOS
/// - Triggered from user-driven or state-driven flows
/// - Uses [IAnimationEngine] for fade + scale transitions
/// - Shows confirm/cancel buttons based on [isInfoDialog] flag
/// - Applies resolved [OverlayUIPresetProps] for icon and color
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
  });

  /// ➟ Cancel action handler
  VoidCallback get _handleCancel =>
      onCancel ?? () => di<IOverlayDispatcher>().dismissCurrent();

  /// ➟ Confirm action handler
  VoidCallback get _handleConfirm =>
      onConfirm ?? () => di<IOverlayDispatcher>().dismissCurrent();
  @override
  Widget build(BuildContext context) {
    final icon = presetProps?.icon;
    final backgroundColor = presetProps?.color;

    /// 🧱 Builds animated Cupertino dialog with fade + scale
    return FadeTransition(
      opacity: engine.opacity,
      child: ScaleTransition(
        scale: engine.scale,
        child: CupertinoAlertDialog(
          /// 🎨 Title section with optional icon and preset color
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

          /// 🧩 Action buttons: Confirm only for info dialogs, Confirm + Cancel otherwise
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

  //
}
