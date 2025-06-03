import 'package:firebase_with_bloc_or_cubit/core/shared_modules/theme/extensions/theme_x.dart';
import 'package:flutter/material.dart';

import '../../../shared_modules/theme/core/app_colors.dart';
import '../constants/_app_constants.dart' show AppSpacing;

/// 🧊 [GlassTileDivider] — Subtle glass-style divider between dialog content and buttons.
/// Used in dialogs with translucent backgrounds and blurred layers.
/// ────────────────────────────────────────────────────────────────
final class GlassTileDivider extends StatelessWidget {
  const GlassTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Column(
      children: [
        const SizedBox(height: AppSpacing.m),
        Container(
          width: double.infinity,
          height: 0.5,
          margin: const EdgeInsets.only(bottom: AppSpacing.xs),
          color: isDark ? AppColors.dividerLightOpacity : AppColors.darkBorder,
        ),
        const SizedBox(height: AppSpacing.s),
      ],
    );
  }
}
