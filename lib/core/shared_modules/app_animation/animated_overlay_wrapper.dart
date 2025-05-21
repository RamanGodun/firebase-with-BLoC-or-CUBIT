import 'package:flutter/material.dart';
import 'new_engines/_animation_engine.dart';

/// 🧱 [AnimatedOverlayWrapper] — universal animation container for overlay widgets
/// ✅ Initializes engine with TickerProvider
/// ✅ Automatically plays animation
/// ✅ Optionally auto-dismisses after [displayDuration]
/// ✅ Calls [onDismiss] after reverse animation completes
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

  ///
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

  ///
  @override
  Widget build(BuildContext context) => widget.builder(_engine);

  ///
  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  //
}

///

///
extension OverlayWidgetX on Widget {
  /// 🧠 Injects dismiss logic into AnimatedOverlayWrapper
  Widget withDispatcherOverlayControl({required VoidCallback onDismiss}) {
    if (this is AnimatedOverlayWrapper) {
      final wrapper = this as AnimatedOverlayWrapper;
      return AnimatedOverlayWrapper(
        engine: wrapper.engine,
        builder: wrapper.builder,
        displayDuration: wrapper.displayDuration,
        onDismiss: onDismiss,
      );
    }
    return this;
  }
}
