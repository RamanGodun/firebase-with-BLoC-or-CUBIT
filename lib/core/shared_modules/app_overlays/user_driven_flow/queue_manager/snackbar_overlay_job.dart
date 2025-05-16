import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../animation_engines/_animation_engine_factory.dart';
import '../../../app_animation/_animation_host.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/widgets/app_snackbar.dart';
import '../../presentation/overlay_presets/preset_props.dart';
import '_job_interface.dart';

final class SnackbarOverlayJob extends OverlayJob {
  final BuildContext context;
  final String message;
  final IconData icon;
  final OverlayUIPresetProps? presetProps;
  final TargetPlatform? platform;

  SnackbarOverlayJob({
    required this.context,
    required this.message,
    required this.icon,
    this.presetProps,
    this.platform,
  });

  @override
  UserDrivenOverlayType get type => UserDrivenOverlayType.snackbar;

  @override
  Duration get duration => presetProps?.duration ?? const Duration(seconds: 2);

  @override
  Future<void> show() async {
    final completer = Completer<void>();

    final entry = OverlayEntry(
      builder:
          (_) => AnimationHost(
            overlayType: UserDrivenOverlayType.snackbar,
            displayDuration: duration,
            onDismiss: completer.complete,
            platform: context.platform.toAnimationPlatform(),
            builderWithEngine:
                (engine) => AppSnackbarWidget(
                  message: message,
                  icon: icon,
                  props: presetProps ?? const OverlayInfoUIPreset().resolve(),
                  platform: platform ?? Theme.of(context).platform,
                ),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(entry);
    return completer.future;
  }
}
