part of 'overlay_widget.dart';

/// 🧩 [OverlayCard] – A reusable styled container for overlay content:
/// - 🖼️ Contains an [Icon] and [TextWidget]
/// - 🎨 Uses theme-aware colors
/// - 🌫️ Includes shadow and border for macOS-style floating effect
//----------------------------------------------------------------

class OverlayCard extends StatelessWidget {
  final IconData icon;
  final String message;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;

  const OverlayCard({
    super.key,
    required this.icon,
    required this.message,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        mainAxisSize: MainAxisSize.min, // 📏 Shrink to fit content
        children: [
          Icon(icon, color: textColor, size: 24),
          const SizedBox(width: 12), // ↔️ Spacing
          Expanded(
            child: TextWidget(message, TextType.titleMedium, color: textColor),
          ),
        ],
      ),
    );
  }
}
