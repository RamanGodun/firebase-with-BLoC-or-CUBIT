import 'package:flutter/material.dart';
import 'new_engines/_animation_engine.dart';

/// 🧱 [AnimatedOverlayWrapper] — universal animation container for overlay widgets
/// ✅ Initializes engine with TickerProvider
/// ✅ Automatically plays animation
/// ✅ Optionally auto-dismisses after [displayDuration]
/// ✅ Calls [onDismiss] after reverse animation
class AnimatedOverlayWrapper extends StatefulWidget {
  /// 💡 Platform-aware engine with pre-resolved animation type
  final DialogAnimationEngine engine;

  /// 🧱 Widget to render inside the overlay (e.g., AndroidDialog / IOSDialog)
  final Widget Function(DialogAnimationEngine engine) builder;

  /// ⏳ Duration before auto-dismiss (set to Duration.zero for manual closing)
  final Duration displayDuration;

  /// 🔁 Called after reverse animation completes
  final VoidCallback? onDismiss;

  const AnimatedOverlayWrapper({
    super.key,
    required this.engine,
    required this.builder,
    required this.displayDuration,
    this.onDismiss,
  });

  @override
  State<AnimatedOverlayWrapper> createState() => _AnimatedOverlayWrapperState();
}

class _AnimatedOverlayWrapperState extends State<AnimatedOverlayWrapper>
    with TickerProviderStateMixin {
  late final DialogAnimationEngine _engine;

  @override
  void initState() {
    super.initState();
    _engine = widget.engine;
    _engine.initialize(this);
    _engine.play();

    if (widget.displayDuration > Duration.zero) {
      Future.delayed(widget.displayDuration, () async {
        await _engine.reverse();
        widget.onDismiss?.call();
      });
    }
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(_engine);
}

///
extension OverlayWidgetX on Widget {
  Duration? get autoDismissDuration {
    if (this is AnimatedOverlayWrapper) {
      return (this as AnimatedOverlayWrapper).displayDuration;
    }
    return null;
  }
}
