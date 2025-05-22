import 'dart:ui' show ImageFilter;
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/constants/_app_constants.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import '../../../animation/animation_engines/_animation_engine.dart';
import '../../../localization/code_base_for_both_options/text_widget.dart';
import '../overlay_presets/preset_props.dart';

/// 🪧 [IOSBanner] — iOS-style animated banner with glassmorphism
/// - Uses [IAnimationEngine] for opacity + scale transitions
/// - Includes border, blur, and shadows for iOS-consistent visuals
/// - Used by both user- and state-driven overlay flows
// -----------------------------------------------------------------------------

final class IOSBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final AnimationEngine engine;

  const IOSBanner({
    super.key,
    required this.message,
    required this.icon,
    required this.engine,
    required this.props,
  });

  ///
  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    // 🎨 Platform-aware dynamic colors
    final backgroundColor =
        isDark ? AppColors.darkOverlay : AppColors.lightOverlay;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final borderColor =
        isDark ? AppColors.overlayDarkBorder : AppColors.overlayLightBorder;

    return Align(
      alignment: const FractionalOffset(0.5, 0.4),

      /// 🎞️ Applies animation via fade + scale transitions
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
                    children: [
                      Icon(icon, color: textColor, size: 24),
                      const SizedBox(width: 12),
                      TextWidget(
                        message,
                        TextType.titleSmall,
                        color: textColor,
                      ),
                      const Spacer(),
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

  //
}
