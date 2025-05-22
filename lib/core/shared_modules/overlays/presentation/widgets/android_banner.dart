import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../animation/animation_engines/_animation_engine.dart';
import '../../../localization/code_base_for_both_options/text_widget.dart';
import '../overlay_presets/preset_props.dart';

/// 🪧 [AndroidBanner] — Android-style animated banner (Material)
/// - Uses [ISlideAnimationEngine] for fade + slide + scale transitions
/// - Appears at the top of the screen with elevation and shadow
/// - Used by both state- and user-driven overlay flows
// -------------------------------------------------------------------

final class AndroidBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final AnimationEngine engine;

  const AndroidBanner({
    super.key,
    required this.message,
    required this.icon,
    required this.props,
    required this.engine,
  });

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
