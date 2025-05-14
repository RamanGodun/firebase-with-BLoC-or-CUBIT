import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../overlay_presets/preset_props.dart';

/// 🧱 Cross-platform [Snackbar] widget, renders based on [platform]
final class AppSnackbarWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final TargetPlatform platform;

  const AppSnackbarWidget({
    required this.message,
    required this.icon,
    required this.props,
    required this.platform,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (platform == TargetPlatform.android) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Expanded(
                  child: TextWidget(
                    message,
                    TextType.bodyMedium,
                    color: Colors.white,
                    isTextOnFewStrings: true,
                  ),
                ),
              ],
            ),
            backgroundColor: props.color,
            duration: props.duration,
            shape: props.shape,
            margin: props.margin,
            behavior: props.behavior,
          ),
        );
      });
      return const SizedBox.shrink();
    }

    // Default to iOS-like
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: props.margin,
          padding: props.contentPadding,
          decoration: BoxDecoration(
            color: props.color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: TextWidget(
                  message,
                  TextType.bodyMedium,
                  color: Colors.white,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
