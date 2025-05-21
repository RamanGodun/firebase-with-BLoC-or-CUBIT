import 'dart:collection' show Queue;
import 'dart:collection';
import '../../../app_config/bootstrap/di_container.dart';
import '../../app_animation/enums_for_animation_module.dart';
import '../state_driven_flow/overlay_dispatcher/overlay_dispatcher_interface.dart';
import 'overlay_tasks/_task_interface.dart';

/// 🧠 [OverlayQueueManager] — Manages user-driven overlay queues by type
/// - Maintains independent FIFO queues per overlay type (banner/snackbar/dialog)
/// - Ensures only one overlay of a given type is active at a time
/// - Executes [OverlayTask.show] and schedules next after dismissal
// ----------------------------------------------------------------------

final class OverlayQueueManager {
  // 📦 Internal task queues by [UserDrivenOverlayType]
  final _queues = <UserDrivenOverlayType, Queue<OverlayTask>>{
    for (final type in UserDrivenOverlayType.values) type: Queue(),
  };

  // 🔄 Tracks whether an overlay is currently active for each type
  final _active = <UserDrivenOverlayType, bool>{
    for (final type in UserDrivenOverlayType.values) type: false,
  };

  /// ➕ Adds [OverlayTask] to corresponding queue and triggers processing
  void enqueue(OverlayTask task) {
    _queues[task.type]!.add(task);
    _processNext(task.type);
  }

  /// ▶️ Processes next overlay in queue if none is active
  void _processNext(UserDrivenOverlayType type) {
    if (_active[type]! || _queues[type]!.isEmpty) return;

    final task = _queues[type]!.removeFirst();
    _active[type] = true;

    final dispatcher = di<IOverlayDispatcher>();
    if (dispatcher.isOverlayActive) {
      _active[type] = false;
      Future.delayed(const Duration(milliseconds: 300), () {
        _processNext(type);
      });
      return;
    }

    task.show().then((_) {
      _active[type] = false;
      _processNext(type);
    });
  }

  //
}
