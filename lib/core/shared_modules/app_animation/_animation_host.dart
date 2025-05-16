// === FIXED AnimationHost with platform awareness and decoupled animation engine ===

import 'package:flutter/material.dart';
import 'animation_engine_factory.dart';
import 'animation_engine_interface.dart';

/// ✅ [AnimationHost] — centralized animation container
/// - Accepts resolved platform and target
/// - Provides IAnimationEngine instance via builder
/// - Manages animation lifecycle and auto-dismiss
class AnimationHost extends StatefulWidget {
  final AnimationTargetType target;
  final TargetPlatform platform; // 👈 passed externally
  final Widget Function(IAnimationEngine engine) builder;
  final Duration displayDuration;
  final VoidCallback? onDismiss;

  const AnimationHost({
    super.key,
    required this.target,
    required this.platform,
    required this.builder,
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
      targetType: widget.target,
      vsync: this,
    );
    _engine.play();
    _autoDismiss();
  }

  void _autoDismiss() {
    Future.delayed(widget.displayDuration, () async {
      await _engine.reverse();
      widget.onDismiss?.call();
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(_engine);
}
