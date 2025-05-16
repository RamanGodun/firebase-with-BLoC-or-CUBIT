import 'dart:ui' show ImageFilter;
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../../animation_engines/__animation_engine_interface.dart';
import '../../../animation_engines/android_banner_animation_engine.dart';
import '../overlay_presets/preset_props.dart';

/// 🎭 [IOSBannerCard] — Stateless widget that builds animated glass UI
/// - Uses provided [IAnimationEngine] for fade + scale transitions
///----------------------------------------------------------------------------
final class IOSBannerCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final IAnimationEngine engine;

  const IOSBannerCard({
    super.key,
    required this.message,
    required this.icon,
    required this.engine,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final backgroundColor =
        isDark ? AppColors.darkOverlay : AppColors.lightOverlay;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final borderColor =
        isDark ? AppColors.overlayDarkBorder : AppColors.overlayLightBorder;

    return Align(
      alignment: const FractionalOffset(0.5, 0.4),
      child: FadeTransition(
        opacity: engine.opacity,
        child: ScaleTransition(
          scale: engine.scale,
          child: Material(
            color: AppColors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: borderColor, width: 1.5),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: textColor, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextWidget(
                          message,
                          TextType.titleMedium,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).withPaddingHorizontal(AppSpacing.xl),
          ),
        ),
      ),
    );
  }
}

/// 🎭 [AndroidBannerCard] — Material-style banner with smooth animation
/// Uses fade + slide + subtle scale effect via [AndroidBannerAnimationEngine]
final class AndroidBannerCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final ISlideAnimationEngine engine;

  const AndroidBannerCard({
    super.key,
    required this.message,
    required this.icon,
    required this.props,
    required this.engine,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SlideTransition(
        position: engine.slide,
        child: FadeTransition(
          opacity: engine.opacity,
          child: ScaleTransition(
            scale: engine.scale,
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(12),
              color: props.color.withOpacity(0.9),
              child: Padding(
                padding: props.contentPadding,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: Colors.white),
                    const SizedBox(width: 8),
                    Flexible(
                      child: TextWidget(
                        message,
                        TextType.bodyMedium,
                        color: context.colorScheme.primary,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        isTextOnFewStrings: true,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
