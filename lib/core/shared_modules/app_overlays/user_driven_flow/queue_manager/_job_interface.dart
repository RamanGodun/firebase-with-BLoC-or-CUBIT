import '../../../animation_engines/_animation_engine_factory.dart';

abstract base class OverlayJob {
  UserDrivenOverlayType get type;
  Duration get duration;
  Future<void> show();
}
