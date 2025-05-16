import 'dart:async';
import 'package:flutter/material.dart';
import '../../../animation_engines/_animation_engine_factory.dart';
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
  Duration get duration => const Duration(milliseconds: 0); // unused

  @override
  Future<void> show() async {
    await showDialog(
      context: context,
      builder:
          (_) => AppDialog(
            title: title,
            content: content,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
            presetProps: presetProps,
            platform: platform ?? Theme.of(context).platform,
            isInfoDialog: isInfoDialog,
          ),
    );
  }
}
