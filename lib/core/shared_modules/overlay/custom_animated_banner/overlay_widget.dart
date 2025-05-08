import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import '../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../../constants/_app_constants.dart';

part 'overlay_card.dart';

/// 🎭 [AnimatedOverlayWidget] – A toast-like animated widget that:
/// - 🔽 Slides in with fade & scale animation
/// - 🖼 Shows icon + message in styled banner
/// Used by [OverlayNotificationService] to display temporary messages.
//----------------------------------------------------------------

final class AnimatedOverlayWidget extends StatefulWidget {
  final String message;
  final IconData icon;

  const AnimatedOverlayWidget({
    super.key,
    required this.message,
    required this.icon,
  });

  @override
  State<AnimatedOverlayWidget> createState() => _AnimatedOverlayWidgetState();
}

class _AnimatedOverlayWidgetState extends State<AnimatedOverlayWidget>
    with TickerProviderStateMixin {
  ///
  static const _animationDuration = Duration(milliseconds: 600);
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    /// 🎞️ Init animation
    _controller = AnimationController(vsync: this, duration: _animationDuration)
      ..forward();
    _opacity = Tween<double>(
      begin: 0,
      end: 1,
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
    _scale = Tween<double>(
      begin: 0.8,
      end: 1,
    ).chain(CurveTween(curve: Curves.elasticOut)).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    /// 🎨 Adapt color scheme to theme
    final isDark = context.isDarkMode;
    final backgroundColor =
        isDark ? AppColors.darkOverlay : AppColors.lightOverlay;
    final textColor = isDark ? AppColors.white : AppColors.black;
    final borderColor =
        isDark ? AppColors.overlayDarkBorder : AppColors.overlayLightBorder;

    return Align(
      alignment: const FractionalOffset(0.5, 0.4), // 📍 Slightly above center
      child: FadeTransition(
        opacity: _opacity,
        child: ScaleTransition(
          scale: _scale,
          child: Material(
            color: AppColors.transparent,
            child: OverlayCard(
              icon: widget.icon,
              message: widget.message,
              textColor: textColor,
              backgroundColor: backgroundColor,
              borderColor: borderColor,
            ).withPaddingHorizontal(AppSpacing.xl), // ↔️ Outer spacing
          ),
        ),
      ),
    );
  }

  /// 🧹 Clean up controller
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  ///
}
