import 'dart:async';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../app_animation/animation_engine_factory.dart';
import '../../../app_animation/_animation_host.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/widgets/banner_card.dart';
import 'job_interface.dart';

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
  OverlayType get type => OverlayType.banner;

  @override
  Duration get duration => const Duration(seconds: 2);

  @override
  Future<void> show() async {
    final completer = Completer<void>();
    final resolvedProps =
        const OverlayInfoUIPreset().resolve(); // ! SHOULD BE changed
    final entry = OverlayEntry(
      builder:
          (_) => AnimationHost(
            target: OverlayType.banner,
            displayDuration: duration,
            onDismiss: completer.complete,
            platform: context.platform,
            builder:
                (engine) => IOSBannerCard(
                  message: message,
                  icon: icon,
                  engine: engine,
                  props: resolvedProps,
                ),
          ),
    );

    Overlay.of(context, rootOverlay: true).insert(entry);
    return completer.future;
  }
}
