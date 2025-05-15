part of 'banner_animated.dart';

/// 🧩 [BannerCard] — Themed container for compact overlay content
/// - 🖼️ Displays [Icon] and [TextWidget] in a styled card
/// - 🌓 Adapts to light/dark theme via injected colors
/// - 🌫️ Mimics macOS-like floating appearance with shadow and border
///----------------------------------------------------------------------------

final class BannerCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  const BannerCard({
    super.key,
    required this.icon,
    required this.message,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(9),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 24,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // 📏 Shrink to fit content
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
    );
  }
}
