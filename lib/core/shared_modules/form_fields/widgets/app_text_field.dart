import 'package:flutter/material.dart';

/// 🧱 [AppTextField] — Reusable, styled text input field used across the app.
/// Supports:
/// - label & prefix icon
/// - error display
/// - focus control
/// - submit action
/// - obscured (e.g. password) mode
//-------------------------------------------------------------------------

class AppTextField extends StatelessWidget {
  final Key? fieldKey;
  final FocusNode focusNode;
  final String label;
  final IconData icon;
  final bool obscure;
  final String? errorText;
  final TextInputType? keyboardType;
  final void Function(String) onChanged;
  final VoidCallback? onSubmitted;
  final Widget? suffixIcon;

  ///
  const AppTextField({
    this.fieldKey,
    required this.focusNode,
    required this.label,
    required this.icon,
    required this.obscure,
    this.suffixIcon,
    this.errorText,
    this.keyboardType,
    required this.onChanged,
    this.onSubmitted,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: fieldKey,
      focusNode: focusNode,
      keyboardType: keyboardType,
      obscureText: obscure,
      textCapitalization:
          keyboardType == TextInputType.name
              ? TextCapitalization.words
              : TextCapitalization.none,
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        filled: true,
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }

  ///
}
