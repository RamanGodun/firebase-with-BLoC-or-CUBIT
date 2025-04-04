import 'package:flutter/material.dart';
import '../../core/utils/helpers/general_helper.dart' show Helpers;
import '../text_widget.dart';

/// 🔘 **[CustomOutlinedButton]** - A reusable, stylish outlined button.
class CustomOutlinedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final double borderRadius;
  final double? width;
  final double? height;
  final bool disabled;

  const CustomOutlinedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.textColor,
    this.borderColor,
    this.padding,
    this.borderRadius = 12.0,
    this.width,
    this.height,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Helpers.getColorScheme(context);
    final primaryColor = colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: disabled ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: disabled ? Colors.grey : textColor ?? primaryColor,
          side: BorderSide(
            color: disabled ? Colors.grey : borderColor ?? primaryColor,
          ),
          padding:
              padding ??
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: TextWidget(
          buttonText,
          TextType.titleMedium,
          color: disabled ? Colors.grey : textColor ?? primaryColor,
        ),
      ),
    );
  }
}
