import 'package:flutter/material.dart';
import '../animation_engines/__animation_engine.dart';

/// 🧱 [AnimatedOverlayWrapper] — universal animation container for overlay widgets
/// ✅ Initializes engine with TickerProvider
/// ✅ Automatically plays animation
/// ✅ Optionally auto-dismisses after [displayDuration]
/// ✅ Calls [onDismiss] after reverse animation completes
///----------------------------------------------------------------

final class AnimatedOverlayWrapper extends StatefulWidget {
  /// 💡 Platform-aware engine with pre-resolved animation type
  final AnimationEngine engine;

  /// 🧱 Widget to render inside the overlay (e.g., AndroidDialog / IOSDialog)
  final Widget Function(AnimationEngine engine) builder;

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
  late final AnimationEngine _engine;

  @override
  void initState() {
    super.initState();
    _engine = widget.engine;
    _engine.initialize(this);
    _engine.play();

    if (widget.displayDuration > Duration.zero) {
      scheduleAutoDismiss();
    }
  }

  /// ⏳ Starts delayed reverse animation with optional callback
  void scheduleAutoDismiss() {
    Future.delayed(widget.displayDuration, () async {
      await _engine.reverse();
      if (mounted) widget.onDismiss?.call();
    });
  }

  @override
  Widget build(BuildContext context) => widget.builder(_engine);

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }
}

///
