part of '_context_extensions.dart';

/// 🧩 [ContextDialogX] — platform-aware dialog utilities for [BuildContext]
//----------------------------------------------------------------//
extension ContextDialogX on BuildContext {
  /// ⚠️ Shows a native-style error dialog with platform-specific design.
  void showErrorDialog(CustomError error) {
    final color = colorScheme.primary;

    final dialogContent = MiniWidgets(
      MWType.error,
      error: error,
      isForDialog: true,
    );

    final dialogTitle = const TextWidget(
      AppStrings.errorDialogTitle,
      TextType.titleMedium,
    );

    final okButton =
        defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.macOS
            ? CupertinoDialogAction(
              onPressed: popView,
              child: TextWidget(
                AppStrings.okButton,
                TextType.titleMedium,
                color: color,
              ),
            )
            : TextButton(
              onPressed: popView,
              child: TextWidget(
                AppStrings.okButton,
                TextType.titleMedium,
                color: color,
              ),
            );

    final dialog =
        (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.macOS)
            ? CupertinoAlertDialog(
              title: dialogTitle,
              content: dialogContent,
              actions: [okButton],
            )
            : AlertDialog(
              title: dialogTitle,
              content: dialogContent,
              actions: [okButton],
            );

    showDialog(context: this, builder: (_) => dialog);
  }
}
