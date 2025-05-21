// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../app_animation/animation_engines/__animation_engine_interface.dart';
import '../../../app_animation/animation_engines/_animation_engine_factory.dart';
import '../../../app_animation/enums_for_animation_module.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/overlay_presets/preset_props.dart';
import '_task_interface.dart';

/// 💬 [DialogOverlayTask] — User-driven platform-aware dialog
/// - Triggered manually via `context.showUserDialog(...)`
/// - Queued and managed by [OverlayQueueManager]
/// - Uses [AnimationHost] for entry/exit transitions and dismissal
/// - Inserts [AppDialog] via [OverlayEntry] at runtime
// ----------------------------------------------------------------------

final class DialogOverlayTask extends OverlayTask {
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

  DialogOverlayTask({
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

  /// ⏳ Dialogs don’t auto-dismiss (manual interaction required)
  @override
  Duration get duration => Duration.zero;

  /// 🧱 Builds and shows dialog via [AnimationHost]
  /// Triggered by queue processor in [OverlayQueueManager]
  @override
  Future<void> show() async {
    final completer = Completer<void>();
    // Selects [AnimationPlatform] (iOS/Android/adaptive)
    final animationPlatform =
        (platform ?? context.platform).toAnimationPlatform();
    // Resolves styling and behavior props
    final resolvedProps = presetProps ?? const OverlayInfoUIPreset().resolve();
    //
    late final OverlayEntry entry;
    late final IAnimationEngine engine;

    /// Creates animation engine for dialog transitions
    engine = AnimationEngineFactory.create(
      platform: animationPlatform,
      target: UserDrivenOverlayType.dialog,
      vsync: Navigator.of(context),
    );

    /// Runs reverse animation and removes entry
    // void animatedDismiss() async {
    //   await engine.reverse();
    //   entry.remove();
    //   completer.complete();
    // }

    /// Builds dialog via [AnimationHost] and injects into Overlay
    // entry = OverlayEntry(
    //   builder: (_) {
    //     return switch (animationPlatform) {
    //       AnimationPlatform.ios || AnimationPlatform.adaptive => IOSAppDialog(
    //         title: title,
    //         content: content,
    //         confirmText: confirmText,
    //         cancelText: cancelText,
    //         onConfirm: onConfirm,
    //         onCancel: onCancel,
    //         presetProps: resolvedProps,
    //         isInfoDialog: isInfoDialog,
    //         isFromUserFlow: true,
    //         engine: engine,
    //         // onAnimatedDismiss: animatedDismiss,
    //       ),
    //       AnimationPlatform.android => AndroidDialog(
    //         title: title,
    //         content: content,
    //         confirmText: confirmText,
    //         cancelText: cancelText,
    //         onConfirm: onConfirm,
    //         onCancel: onCancel,
    //         presetProps: resolvedProps,
    //         isInfoDialog: isInfoDialog,
    //         isFromUserFlow: true,
    //         engine: engine,
    //         // onAnimatedDismiss: animatedDismiss,
    //       ),
    //     };
    //   },
    // );

    /// Injects the dialog into root overlay and starts animation
    // Overlay.of(context, rootOverlay: true).insert(entry); // ? bellow alt syntaxes, check it
    // context.insertOverlayEntry(entry);
    engine.play();
    return completer.future;
  }

  ///
}
