import 'package:flutter/material.dart';
import 'text_widget.dart';

/// 🎛 Types for MiniWidgets.
enum MWType { loading, error }

/// 📦 Reusable widget for loading & error states.
class AppMiniWidgets extends StatelessWidget {
  final MWType type;
  final Object? error;
  final StackTrace? stackTrace;

  const AppMiniWidgets(this.type, {super.key, this.error, this.stackTrace});

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case MWType.loading:
        return const Center(child: CircularProgressIndicator.adaptive());

      case MWType.error:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                error?.toString() ?? 'An unknown error occurred',
                TextType.error,
                isTextOnFewStrings: true,
              ),
              if (stackTrace != null) ...[
                const SizedBox(height: 8),
                const TextWidget(
                  'StackTrace logged 📜',
                  TextType.caption,
                  color: Colors.grey,
                ),
              ],
            ],
          ),
        );
    }
  }
}
