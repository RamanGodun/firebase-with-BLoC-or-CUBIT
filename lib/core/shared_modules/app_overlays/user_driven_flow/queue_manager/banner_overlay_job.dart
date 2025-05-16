import 'dart:async' show Completer;
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
import '../../../animation_engines/_animation_engine_factory.dart';
import '../../../animation_engines/__animation_engine_interface.dart';
import '../../../app_animation/_animation_host.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/widgets/app_banners.dart';
import '_job_interface.dart';

final class BannerOverlayJob extends OverlayJob {
  final BuildContext context;
  final String message;
  final IconData icon;

  BannerOverlayJob({
    required this.context,
    required this.message,
    required this.icon,
  });

  @override
  UserDrivenOverlayType get type => UserDrivenOverlayType.banner;

  @override
  Duration get duration => const Duration(seconds: 2);

  @override
  Future<void> show() async {
    final completer = Completer<void>();
    final resolvedProps = const OverlayInfoUIPreset().resolve();
    final animationPlatform = context.platform.toAnimationPlatform();

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder:
          (_) => AnimationHost(
            overlayType: UserDrivenOverlayType.banner,
            displayDuration: duration,
            platform: animationPlatform,
            onDismiss: () {
              entry.remove();
              completer.complete();
            },
            builderWithEngine:
                (engine) => switch (animationPlatform) {
                  AnimationPlatform.ios ||
                  AnimationPlatform.adaptive => IOSBannerCard(
                    message: message,
                    icon: icon,
                    engine: engine,
                    props: resolvedProps,
                  ),
                  AnimationPlatform.android => AndroidBannerCard(
                    message: message,
                    icon: icon,
                    engine: engine as ISlideAnimationEngine,
                    props: resolvedProps,
                  ),
                },
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(entry);
    return completer.future;
  }

  ///
}
