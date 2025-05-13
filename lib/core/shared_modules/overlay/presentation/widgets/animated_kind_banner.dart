import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../overlay_presets/preset_props.dart';

/// 🪧 [AnimatedPresetBanner] — Overlay banner with dynamic icon + color + message.
/// Used for `showErrorBanner`, `showSuccessBanner`, etc.
final class AnimatedPresetBanner extends StatelessWidget {
  final String message;
  final OverlayUIPresetProps props;

  const AnimatedPresetBanner({
    super.key,
    required this.message,
    required this.props,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(12),
        color: props.color.withOpacity(0.9),
        child: Container(
          padding: props.contentPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(props.icon, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: TextWidget(
                  message,
                  TextType.bodyMedium,
                  color: Colors.white,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ).withPaddingAll(12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
