// ignore_for_file: unused_local_variable

import 'dart:async' show Completer;
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
import '../../../app_animation/enums_for_animation_module.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '_task_interface.dart';

/// 🪧 [BannerOverlayTask] — User-driven platform-aware banner
/// - Triggered manually via `context.showUserBanner(...)`
/// - Queued and managed by [OverlayQueueManager]
/// - Uses [AnimationHost] for entrance animation and auto-dismiss
/// - Inserts [AppBanner] via [OverlayEntry] at runtime
// ----------------------------------------------------------------------

final class BannerOverlayTask extends OverlayTask {
  final BuildContext context;
  final String message;
  final IconData icon;

  BannerOverlayTask({
    required this.context,
    required this.message,
    required this.icon,
  });

  @override
  UserDrivenOverlayType get type => UserDrivenOverlayType.banner;

  /// ⏱️ Banner auto-dismisses after fixed duration
  @override
  Duration get duration => const Duration(seconds: 2);

  /// 🧱 Builds and shows the banner via [AnimationHost]
  /// Triggered by queue processor in [OverlayQueueManager]
  @override
  Future<void> show() async {
    final completer = Completer<void>();
    // Resolves style preset for animation & colors
    final resolvedProps = const OverlayInfoUIPreset().resolve();
    // Selects [AnimationPlatform] (iOS/Android/adaptive)
    final animationPlatform = context.platform.toAnimationPlatform();
    // Creates overlay entry with animated banner content
    late final OverlayEntry entry;

    // ///
    // entry = OverlayEntry(
    //   builder:
    //       (_) => AnimationHost(
    //         overlayType: UserDrivenOverlayType.banner,
    //         displayDuration: duration,
    //         platform: animationPlatform,
    //         onDismiss: () {
    //           entry.remove();
    //           completer.complete();
    //         },
    //         // 🎯 Builds platform-specific banner with resolved props & engine
    //         builderWithEngine:
    //             (engine) => switch (animationPlatform) {
    //               AnimationPlatform.ios ||
    //               AnimationPlatform.adaptive => IOSBanner(
    //                 message: message,
    //                 icon: icon,
    //                 engine: engine,
    //                 props: resolvedProps,
    //               ),
    //               AnimationPlatform.android => AndroidBanner(
    //                 message: message,
    //                 icon: icon,
    //                 engine: engine as ISlideAnimationEngine,
    //                 props: resolvedProps,
    //               ),
    //             },
    //       ),
    // );

    /// Inserts entry into root overlay
    // Overlay.of(context, rootOverlay: true).insert(entry); // ? bellow alt syntaxes, check it
    // context.insertOverlayEntry(entry);
    return completer.future;
  }

  ///
}
