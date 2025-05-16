import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import '../../../../shared_presentation/shared_widgets/text_widget.dart';
import '../../../animation_engines/__animation_engine_interface.dart';
import '../overlay_presets/preset_props.dart';

final class IOSSnackbarCard extends StatelessWidget {
  final String message;
  final IconData icon;
  final OverlayUIPresetProps props;
  final IAnimationEngine engine;

  const IOSSnackbarCard({
    super.key,
    required this.message,
    required this.icon,
    required this.props,
    required this.engine,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
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

  @override
  Widget build(BuildContext context) {
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
}
