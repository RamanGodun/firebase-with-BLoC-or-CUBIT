import 'package:flutter/material.dart';

enum ButtonType { filled, text }

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final ButtonType type;
  final Color? foregroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget child;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.type,
    this.foregroundColor,
    this.fontSize = 17,
    this.fontWeight = FontWeight.w600,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return type == ButtonType.filled
        ? _buildMacFilledButton()
        : _buildMacTextButton();
  }

  Widget _buildMacFilledButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(-2, -2),
            ),
          ],
        ),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.grey.shade200.withOpacity(0.7),
            textStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildMacTextButton() {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor ?? Colors.blueAccent,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      child: child,
    );
  }
}

/*
class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget child;

  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          textStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
        ),
        child: child,
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final Color? foregroundColor;
  final double fontSize;
  final FontWeight fontWeight;
  final Widget child;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    this.foregroundColor,
    required this.fontSize,
    required this.fontWeight,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
      ),
      child: child,
    );
  }
}

enum ButtonType {
  filled,
  text,
}

 */
