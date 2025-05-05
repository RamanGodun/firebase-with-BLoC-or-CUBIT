import 'package:flutter/material.dart';

/// 🧱 [AppTextField] — Універсальне текстове поле з підтримкою:
/// - іконки
/// - валідації
/// - сабміту
/// - керування фокусом
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

  const AppTextField({
    this.fieldKey,
    required this.focusNode,
    required this.label,
    required this.icon,
    required this.obscure,
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
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }
}
