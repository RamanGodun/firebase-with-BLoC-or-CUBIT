import 'package:flutter/material.dart';

import '../../../core/modules_shared/localization/app_localizer.dart';

/// 🧱 [AppTextField] — Reusable, styled text input field used across the app.
/// Supports:
/// - label & prefix icon
/// - error display
/// - focus control
/// - submit action
/// - obscured (e.g. password) mode

class AppTextField extends StatelessWidget {
  //---------------------------------------

  final Key? fieldKey;
  final FocusNode focusNode;
  final String label;
  final String? fallback;
  final IconData icon;
  final bool obscure;
  final String? errorText;
  final TextInputType? keyboardType;
  final void Function(String) onChanged;
  final VoidCallback? onSubmitted;
  final Widget? suffixIcon;

  const AppTextField({
    this.fieldKey,
    required this.focusNode,
    required this.label,
    this.fallback,
    required this.icon,
    required this.obscure,
    this.suffixIcon,
    this.errorText,
    this.keyboardType,
    required this.onChanged,
    this.onSubmitted,
    super.key,
  });

  ///

  @override
  Widget build(BuildContext context) {
    //
    final resolvedLabel = _resolveLabel(label, fallback);

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
        labelText: resolvedLabel,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        errorText: errorText,
      ),
      onChanged: onChanged,
      onSubmitted: (_) => onSubmitted?.call(),
    );
  }

  /// 🔤 Resolves [label] as localization key if applicable.
  /// - Uses [AppLocalizer.t] if initialized and key-like (contains '.')
  /// - Falls back to [fallback] or raw label
  String _resolveLabel(String raw, String? fallback) {
    final isLocalCaseKey = raw.contains('.');
    if (isLocalCaseKey && AppLocalizer.isInitialized) {
      return AppLocalizer.t(raw, fallback: fallback ?? raw);
    }
    return raw;
  }

  //
}
