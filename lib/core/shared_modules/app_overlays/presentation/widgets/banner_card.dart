import 'dart:ui' show ImageFilter;
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../../app_animation/animation_engine_interface.dart';

/// 🎭 [BannerCard] — Stateless widget that builds animated glass UI
/// - Uses provided [IAnimationEngine] for fade + scale transitions
///----------------------------------------------------------------------------
final class BannerCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final IAnimationEngine engine;

  const BannerCard({
    super.key,
    required this.message,
    required this.icon,
    required this.engine,
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
