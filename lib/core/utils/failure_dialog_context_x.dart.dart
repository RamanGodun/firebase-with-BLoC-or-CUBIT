part of 'extensions/context_extensions/_context_extensions.dart';

/// 🧩 [ContextDialogX] — platform-aware dialog utilities for [BuildContext]
/// ⚠️ Shows a native-style error dialog for [Failure]
/// Automatically chooses platform-specific dialog: Cupertino / Material.
//-------------------------------------------------------------------------

extension ContextDialogX on BuildContext {
  ///

  void showFailureDialog(
    Failure failure, {
    String? title,
    String? buttonText,
    VoidCallback? onClose,
  }) {
    final color = colorScheme.primary;
    final platform = Theme.of(this).platform;

    final titleWidget = TextWidget(
      title ?? AppStrings.errorDialogTitle,
      TextType.titleMedium,
    );

    final content = TextWidget(failure.formattedMessage, TextType.bodyMedium);

    final okButton = switch (platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => CupertinoDialogAction(
        onPressed: () {
          popView();
          onClose?.call();
        },
        child: TextWidget(
          buttonText ?? AppStrings.okButton,
          TextType.titleMedium,
          color: color,
        ),
      ),
      _ => TextButton(
        onPressed: () {
          popView();
          onClose?.call();
        },
        child: TextWidget(
          buttonText ?? AppStrings.okButton,
          TextType.titleMedium,
          color: color,
        ),
      ),
    };

    final dialog = switch (platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => CupertinoAlertDialog(
        title: titleWidget,
        content: content,
        actions: [okButton],
      ),
      _ => AlertDialog(
        title: titleWidget,
        content: content,
        actions: [okButton],
      ),
    };

    showDialog(context: this, builder: (_) => dialog);
  }
}
