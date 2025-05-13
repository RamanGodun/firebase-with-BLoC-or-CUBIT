import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../overlay_presets/preset_props.dart';
import 'overlay_widget.dart';

class AppBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final TargetPlatform platform;

  const AppBanner({
    required this.message,
    required this.icon,
    required this.props,
    required this.platform,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return switch (platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => AnimatedOverlayWidget(
        message: message,
        icon: icon,
      ),
      _ => Align(
        alignment: Alignment.topCenter,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(12),
          color: props.color.withOpacity(0.9),
          child: Padding(
            padding: props.contentPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Colors.white),
                const SizedBox(width: 8),
                Flexible(
                  child: TextWidget(
                    message,
                    TextType.bodyMedium,
                    color: context.colorScheme.primary,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    };
  }
}
