import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../app_animation/animation_engines/_animation_engine.dart';
import '../../../app_localization/code_base_for_both_options/text_widget.dart';
import '../overlay_presets/preset_props.dart';

/// 🍞 [AndroidSnackbarCard] — Animated Material snackbar for Android
/// - Uses [ISlideAnimationEngine] for fade + slide transition
/// - Built with resolved [OverlayUIPresetProps] styling
/// - Used by overlay tasks or state-driven snackbar flows
// -----------------------------------------------------------------------

final class AndroidSnackbarCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final AnimationEngine engine;

  const AndroidSnackbarCard({
    super.key,
    required this.message,
    required this.icon,
    required this.props,
    required this.engine,
  });

  ///
  @override
  Widget build(BuildContext context) {
    final content = FadeTransition(
      opacity: engine.opacity,
      child: ScaleTransition(
        scale: engine.scale,
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
                    isTextOnFewStrings: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Align(
      alignment: Alignment.topCenter,
      child:
          engine.slide != null
              ? SlideTransition(position: engine.slide!, child: content)
              : content,
    );
    //
  }

  ///
}
