part of 'overlay_service.dart';

/// 🎭 [_AnimatedOverlayWidget] — fades and scales in a styled message
class _AnimatedOverlayWidget extends HookWidget {
  final String message;
  final IconData icon;

  const _AnimatedOverlayWidget({required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    )..forward();

    final opacity = animationController.drive(
      Tween<double>(begin: 0, end: 1).chain(CurveTween(curve: Curves.easeOut)),
    );

    final scale = animationController.drive(
      Tween<double>(
        begin: 0.8,
        end: 1,
      ).chain(CurveTween(curve: Curves.elasticOut)),
    );

    final colorScheme = Helpers.getColorScheme(context);
    final isDark = colorScheme.brightness == Brightness.dark;

    final backgroundColor =
        isDark
            ? AppConstants.overlayDarkBackground
            : AppConstants.overlayLightBackground;
    final textColor =
        isDark
            ? AppConstants.overlayDarkTextColor
            : AppConstants.overlayLightTextColor;
    final borderColor =
        isDark
            ? AppConstants.overlayDarkBorder
            : AppConstants.overlayLightBorder;

    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: MediaQuery.of(context).size.width * 0.1,
          right: MediaQuery.of(context).size.width * 0.1,
          child: FadeTransition(
            opacity: opacity,
            child: ScaleTransition(
              scale: scale,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColor, width: 1.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
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
            ),
          ),
        ),
      ],
    );
  }
}
