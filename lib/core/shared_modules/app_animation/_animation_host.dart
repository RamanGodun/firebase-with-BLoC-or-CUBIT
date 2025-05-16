import 'package:flutter/material.dart';
import '../animation_engines/_animation_engine_factory.dart';
import '../animation_engines/__animation_engine_interface.dart';

class AnimationHost extends StatefulWidget {
  final UserDrivenOverlayType overlayType;
  final AnimationPlatform platform;
  final Duration displayDuration;
  final VoidCallback? onDismiss;
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

class _AnimationHostState extends State<AnimationHost>
    with TickerProviderStateMixin {
  late final IAnimationEngine _engine;

  @override
  void initState() {
    super.initState();
    _engine = AnimationEngineFactory.create(
      platform: widget.platform,
      target: widget.overlayType,
      vsync: this,
    );
    _engine.play();
    if (widget.displayDuration > Duration.zero) {
      _autoDismiss();
    }
  }

  void _autoDismiss() {
    Future.delayed(widget.displayDuration, () async {
      await _engine.reverse();
      widget.onDismiss?.call();
    });
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builderWithEngine(_engine);
}
