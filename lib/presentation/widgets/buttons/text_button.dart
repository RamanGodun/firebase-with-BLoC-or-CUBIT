import 'package:flutter/material.dart';
import '../../widgets/text_widget.dart';

/// 🔁 A reusable redirect-style text button with optional disabled state.
class RedirectTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final bool isDisabled;

  const RedirectTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      child: TextWidget(label, TextType.bodyMedium, isUnderlined: true),
    );
  }
}
