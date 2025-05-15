import 'dart:ui';

import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../app_config/bootstrap/di_container.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../../../shared_presentation/constants/_app_constants.dart';
import '../../../app_animation/banner_animation.dart';

part 'banner_card.dart';

/// 🎭 [AnimatedBanner] — Animated toast-like widget for lightweight notifications
/// - ⬇️ Slides in with fade and elastic scale
/// - 🖼️ Displays icon + message inside styled [BannerCard]
/// - 🌓 Adapts to light/dark theme automatically
///----------------------------------------------------------------------------

final class AnimatedBanner extends StatefulWidget {
  final String message;
  final IconData icon;

  const AnimatedBanner({super.key, required this.message, required this.icon});

  @override
  State<AnimatedBanner> createState() => _AnimatedBannerState();
}

class _AnimatedBannerState extends State<AnimatedBanner>
    with TickerProviderStateMixin {
  //
  // 🎞️ Animation controller and tweens
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;
  @override
  void initState() {
    super.initState();
    final service = di<BannerAnimationService>();
    _controller = service.init(this);
    _opacity = service.opacity();
    _scale = service.scale();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const FractionalOffset(0.5, 0.4),
      child: FadeTransition(
        opacity: _opacity,
        child: ScaleTransition(
          scale: _scale,
          child: BannerCard(
            icon: widget.icon,
            message: widget.message,
            textColor: context.isDarkMode ? AppColors.white : AppColors.black,
            backgroundColor:
                context.isDarkMode
                    ? AppColors.darkOverlay
                    : AppColors.lightOverlay,
            borderColor:
                context.isDarkMode
                    ? AppColors.overlayDarkBorder
                    : AppColors.overlayLightBorder,
          ).withPaddingHorizontal(AppSpacing.xl),
        ),
      ),
    );
  }

  /// 🧹 Clean up controller
  @override
  void dispose() {
    di<BannerAnimationService>().dispose();
    super.dispose();
  }

  ///
}
