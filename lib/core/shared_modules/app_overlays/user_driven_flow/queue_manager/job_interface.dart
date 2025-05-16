import '../../../app_animation/animation_engine_factory.dart';

abstract base class OverlayJob {
  OverlayType get type;
  Duration get duration;
  Future<void> show();
}
