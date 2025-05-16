import 'dart:collection' show Queue;
import 'dart:collection';
import '../../../animation_engines/_animation_engine_factory.dart';
import '_job_interface.dart';

// === QUEUE MANAGER ===

final class OverlayQueueManager {
  final _queues = <UserDrivenOverlayType, Queue<OverlayJob>>{
    for (final type in UserDrivenOverlayType.values) type: Queue(),
  };

  final _active = <UserDrivenOverlayType, bool>{
    for (final type in UserDrivenOverlayType.values) type: false,
  };

  void enqueue(OverlayJob job) {
    _queues[job.type]!.add(job);
    _processNext(job.type);
  }

  void _processNext(UserDrivenOverlayType type) {
    if (_active[type]! || _queues[type]!.isEmpty) return;
    final job = _queues[type]!.removeFirst();
    _active[type] = true;

    job.show().then((_) {
      _active[type] = false;
      _processNext(type);
    });
  }
}
