import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../../../animation/animation_engines/_animation_engine.dart';
import '../../../localization/code_base_for_both_options/text_widget.dart';
import '../overlay_presets/preset_props.dart';

/// 🍎 [IOSSnackbarCard] — Cupertino-style snackbar for iOS/macOS
/// - Glassmorphic UI with fade + scale animation via [IAnimationEngine]
/// - Used by [AnimationHost] in user- or state-driven flows
/// - Renders bottom-aligned snackbar with custom style and layout
final class IOSSnackbarCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final AnimationEngine engine;

  const IOSSnackbarCard({
    super.key,
    required this.message,
    required this.icon,
    required this.props,
    required this.engine,
  });

  /// 🧱 Builds the animated snackbar widget with glass effect and props
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      // Animates opacity and scale using the provided engine
      child: FadeTransition(
        opacity: engine.opacity,
        child: ScaleTransition(
          scale: engine.scale,
          child: Material(
            color: Colors.transparent,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  margin: props.margin,
                  padding: props.contentPadding,
                  decoration: BoxDecoration(
                    color: props.color.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
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
            ),
          ),
        ),
      ),
    );
  }
}
