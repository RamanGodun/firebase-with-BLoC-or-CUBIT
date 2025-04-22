part of '_context_extensions.dart';

/// 📢 [ContextSnackbarX] — Snackbar utilities for quick feedback
extension ContextSnackbarX on BuildContext {
  void showSnackbar(String message) {
    ScaffoldMessenger.of(
      this,
    ).showSnackBar(SnackBar(content: TextWidget(message, TextType.bodyLarge)));
  }
}
