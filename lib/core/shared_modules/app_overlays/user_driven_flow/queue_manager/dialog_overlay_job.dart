import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../animation_engines/__animation_engine_interface.dart';
import '../../../animation_engines/_animation_engine_factory.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/widgets/app_dialog.dart';
import '../../presentation/overlay_presets/preset_props.dart';
import '_job_interface.dart';

final class DialogOverlayJob extends OverlayJob {
  final BuildContext context;
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresetProps? presetProps;
  final TargetPlatform? platform;
  final bool isInfoDialog;

  DialogOverlayJob({
    required this.context,
    required this.title,
    required this.content,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.presetProps,
    this.platform,
    this.isInfoDialog = false,
  });

  @override
  UserDrivenOverlayType get type => UserDrivenOverlayType.dialog;

  @override
  Duration get duration => Duration.zero;

  @override
  Future<void> show() async {
    final completer = Completer<void>();
    final animationPlatform =
        (platform ?? context.platform).toAnimationPlatform();
    final resolvedProps = presetProps ?? const OverlayInfoUIPreset().resolve();

    late final OverlayEntry entry;
    late final IAnimationEngine engine;

    engine = AnimationEngineFactory.create(
      platform: animationPlatform,
      target: UserDrivenOverlayType.dialog,
      vsync: Navigator.of(context),
    );

    void animatedDismiss() async {
      await engine.reverse();
      entry.remove();
      completer.complete();
    }

    entry = OverlayEntry(
      builder: (_) {
        return switch (animationPlatform) {
          AnimationPlatform.ios || AnimationPlatform.adaptive => IOSAppDialog(
            title: title,
            content: content,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
            presetProps: resolvedProps,
            isInfoDialog: isInfoDialog,
            isFromUserFlow: true,
            engine: engine,
            onAnimatedDismiss: animatedDismiss,
          ),
          AnimationPlatform.android => AndroidAppDialog(
            title: title,
            content: content,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
            presetProps: resolvedProps,
            isInfoDialog: isInfoDialog,
            isFromUserFlow: true,
            engine: engine,
            onAnimatedDismiss: animatedDismiss,
          ),
        };
      },
    );

    Overlay.of(context, rootOverlay: true).insert(entry);
    engine.play();
    return completer.future;
  }
}
