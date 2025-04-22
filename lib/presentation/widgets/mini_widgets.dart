import 'package:firebase_with_bloc_or_cubit/core/utils_and_services/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils_and_services/errors_handling/custom_error.dart';
import 'text_widget.dart';

/// 🔧 Enum for defining types of mini UI widgets
enum MWType { loading, error }

/// 📦 [MiniWidgets] — lightweight reusable widgets for loading & error display
class MiniWidgets extends StatelessWidget {
  final MWType type;
  final CustomError? error;
  // final Object? error;
  final StackTrace? stackTrace;
  final String? errorDialogTitle;
  final bool isForDialog;

  const MiniWidgets(
    this.type, {
    super.key,
    this.error,
    this.stackTrace,
    this.errorDialogTitle,
    this.isForDialog = true,
  });

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      MWType.loading => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
      MWType.error => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isForDialog == false)
              TextWidget(
                errorDialogTitle ?? AppStrings.errorDialogTitle,
                TextType.error,
                isTextOnFewStrings: true,
              ),
            if (error != null) ...[
              const SizedBox(height: 10),
              TextWidget(
                _formatError(error!),
                TextType.bodySmall,
                isTextOnFewStrings: true,
                alignment: TextAlign.left,
              ),
            ],
          ],
        ).withPaddingHorizontal(AppSpacing.l),
      ),
    };
  }

  /// 🧠 Fallback-safe formatter for [CustomError]
  String _formatError(CustomError error) {
    final code = error.code.isNotEmpty ? error.code : 'unknown';
    final plugin = error.plugin.isNotEmpty ? error.plugin : 'unknown';
    final message =
        error.message.isNotEmpty ? error.message : 'Something went wrong';

    return 'code: $code\nplugin: $plugin\nmessage: $message';
  }
}
