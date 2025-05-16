import 'package:flutter/material.dart';
import '../animation_engines/__animation_engine_interface.dart';
import '../animation_engines/_animation_engine_factory.dart';
import 'enums_for_animation_module.dart';

/// 🎞️ [AnimationHost] — Wrapper widget for overlay entry animations
/// - Manages platform-specific animation engines via [AnimationEngineFactory]
/// - Automatically plays forward and reverse transitions
/// - Triggers [onDismiss] after [displayDuration] (if set)
//--------------------------------------------------------

class AnimationHost extends StatefulWidget {
  /// Overlay type (used to determine animation configuration)
  final UserDrivenOverlayType overlayType;
  // Platform to resolve animation engine (e.g. iOS, Android)
  final AnimationPlatform platform;
  // Duration to display the overlay before auto-dismiss
  final Duration displayDuration;
  // Callback invoked after dismissal animation completes
  final VoidCallback? onDismiss;
  // Builder that provides the active [IAnimationEngine] to the widget
  final Widget Function(IAnimationEngine engine) builderWithEngine;

  const AnimationHost({
    super.key,
    required this.overlayType,
    required this.platform,
    required this.builderWithEngine,
    this.displayDuration = const Duration(seconds: 2),
    this.onDismiss,
  });

  @override
  State<AnimationHost> createState() => _AnimationHostState();
}

///
class _AnimationHostState extends State<AnimationHost>
    with TickerProviderStateMixin {
  /// Engine responsible for platform-aware animation control
  late final IAnimationEngine _engine;

  @override
  void initState() {
    super.initState();
    // Initialize the animation engine based on platform and overlay type
    _engine = AnimationEngineFactory.create(
      platform: widget.platform,
      target: widget.overlayType,
      vsync: this,
    );
    _engine.play();
    // If duration is non-zero, auto-dismiss after timeout
    if (widget.displayDuration > Duration.zero) {
      _autoDismiss();
    }
  }

  /// Automatically dismisses the overlay by reversing the animation and calling onDismiss
  void _autoDismiss() {
    Future.delayed(widget.displayDuration, () async {
      await _engine.reverse();
      widget.onDismiss?.call();
    });
  }

  /// 🧹 Cleans up animation resources when the overlay is removed
  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  /// 🧱 Builds the animated widget tree using the resolved [IAnimationEngine]
  @override
  Widget build(BuildContext context) => widget.builderWithEngine(_engine);

  ///
}
