import 'dart:async' show Completer;
import 'animation_engines/__animation_engine_interface.dart';

/// 🔁 [OverlayAnimationHandle] — Enables external animation dismissal trigger
final class OverlayAnimationHandle {
  final Completer<void> _initCompleter = Completer<void>();
  late IAnimationEngine _engine;

  /// 📦 Binds the animation engine to this handle (called by AnimationHost)
  void bind(IAnimationEngine engine) {
    _engine = engine;
    _initCompleter.complete();
  }

  /// ⏪ Triggers reverse animation — supports [fast] collapse for conflict strategy
  Future<void> reverse({bool fast = false}) async {
    await _initCompleter.future;
    await _engine.reverse(fast: fast);
  }
}
