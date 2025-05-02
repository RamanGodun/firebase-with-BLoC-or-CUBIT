part of 'overlay_widget.dart';

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
            child: TextWidget(message, TextType.titleMedium, color: textColor),
          ),
        ],
      ),
    );
  }
}
