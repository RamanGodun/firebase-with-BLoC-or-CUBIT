import 'dart:async' show Completer;
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_overlays/user_driven_flow/user_driven_flow_context_x.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
import '../../../animation_engines/__animation_engine_interface.dart';
import '../../../app_animation/_animation_host.dart';
import '../../../app_animation/enums_for_animation_module.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/overlay_presets/preset_props.dart';
import '../../presentation/widgets/android_snackbar.dart';
import '../../presentation/widgets/ios_snackbar.dart';
import '_task_interface.dart';

/// 🍞 [SnackbarOverlayTask] — User-driven platform-aware snackbar
/// - Triggered manually via `context.showUserSnackbar(...)`
/// - Queued and executed by [OverlayQueueManager]
/// - Built and animated via [AnimationHost] with platform-aware behavior
/// - Automatically dismissed after [duration]
// ----------------------------------------------------------------------

final class SnackbarOverlayTask extends OverlayTask {
  final BuildContext context;
  final String message;
  final IconData icon;
  final OverlayUIPresetProps? presetProps;
  final TargetPlatform? platform;

  SnackbarOverlayTask({
    required this.context,
    required this.message,
    required this.icon,
    this.presetProps,
    this.platform,
  });

  @override
  UserDrivenOverlayType get type => UserDrivenOverlayType.snackbar;

  /// ⏱️ Duration defines auto-dismiss timeout
  @override
  Duration get duration => presetProps?.duration ?? const Duration(seconds: 2);

  /// 🧱 Builds and animates snackbar via [AnimationHost]
  /// Executed by queue processor at runtime
  @override
  Future<void> show() async {
    final completer = Completer<void>();
    // Resolves props (color, shape, icon, duration)
    final resolvedProps = presetProps ?? const OverlayInfoUIPreset().resolve();
    // Determines platform (iOS / Android / adaptive)
    final animationPlatform = context.platform.toAnimationPlatform();
    late final OverlayEntry entry;

    /// Builds snackbar using platform-specific [engine]
    entry = OverlayEntry(
      builder:
          (_) => AnimationHost(
            overlayType: UserDrivenOverlayType.snackbar,
            displayDuration: duration,
            platform: animationPlatform,
            onDismiss: () {
              entry.remove();
              completer.complete();
            },
            builderWithEngine:
                (engine) => switch (animationPlatform) {
                  AnimationPlatform.ios ||
                  AnimationPlatform.adaptive => IOSSnackbarCard(
                    message: message,
                    icon: icon,
                    engine: engine,
                    props: resolvedProps,
                  ),
                  AnimationPlatform.android => AndroidSnackbarCard(
                    message: message,
                    icon: icon,
                    engine: engine as ISlideAnimationEngine,
                    props: resolvedProps,
                  ),
                },
          ),
    );

    /// Injects snackbar into root overlay
    // Overlay.of(context, rootOverlay: true).insert(entry);  // ? bellow alt syntaxes, check it
    context.insertOverlayEntry(entry);
    return completer.future;
  }

  ///
}
