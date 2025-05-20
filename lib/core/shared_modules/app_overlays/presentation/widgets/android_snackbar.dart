import 'package:flutter/material.dart';
import '../../../app_localization/code_base_for_both_options/text_widget.dart';
import '../../../app_animation/animation_engines/__animation_engine_interface.dart';
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
  final ISlideAnimationEngine engine;

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
    /// 🧱 Composed snackbar with animated slide & fade
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: engine.slide,
        child: FadeTransition(
          opacity: engine.opacity,
          child: Material(
            elevation: 6,
            borderRadius: BorderRadius.circular(8),
            color: props.color.withOpacity(0.95),
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
                      color: Colors.white,
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
      ),
    );
  }

  //
}
