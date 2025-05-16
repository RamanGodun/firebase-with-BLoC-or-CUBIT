import 'dart:collection' show Queue;
import 'dart:collection';
import '../../../app_animation/animation_engine_factory.dart';
import 'job_interface.dart';

// === QUEUE MANAGER ===

final class OverlayQueueManager {
  final _queues = <OverlayType, Queue<OverlayJob>>{
    for (final type in OverlayType.values) type: Queue(),
  };

  final _active = <OverlayType, bool>{
    for (final type in OverlayType.values) type: false,
  };

  void enqueue(OverlayJob job) {
    _queues[job.type]!.add(job);
    _processNext(job.type);
  }

  void _processNext(OverlayType type) {
    if (_active[type]! || _queues[type]!.isEmpty) return;
    final job = _queues[type]!.removeFirst();
    _active[type] = true;

    job.show().then((_) {
      _active[type] = false;
      _processNext(type);
    });
  }
}
