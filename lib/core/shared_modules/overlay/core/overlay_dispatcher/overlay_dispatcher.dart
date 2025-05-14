import 'dart:collection';
import 'package:flutter/material.dart';
import '../../../loggers/_app_error_logger.dart';
import '../../presentation/overlay_entries/_overlay_entries.dart';
import '../tap_through_overlay_barrier.dart';
import '../conflicts_strategy/conflict_resolver.dart';
import '../conflicts_strategy/conflicts_strategy.dart';
import 'overlay_dispatcher_interface.dart';

/// 🧠 [OverlayDispatcher] – Handles overlay lifecycle:
/// - Queueing requests
/// - Resolving conflicts
/// - Managing overlay insertion & dismissal
/// - Centralized logging
///----------------------------------------------------------------

final class OverlayDispatcher implements IOverlayDispatcher {
  OverlayDispatcher._();
  static final OverlayDispatcher _instance = OverlayDispatcher._();
  factory OverlayDispatcher() => _instance;

  final Queue<_OverlayQueueItem> _queue = Queue();
  OverlayEntry? _activeEntry;
  OverlayUIEntry? _activeRequest;
  bool _isProcessing = false;

  /// 🟢 Whether the current overlay can be dismissed externally.
  @override
  bool get canBeDismissedExternally =>
      _activeRequest?.dismissPolicy == OverlayDismissPolicy.dismissible;

  /// 📥 Adds a new request to the queue, resolves conflicts if needed.
  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) {
    debugPrint(
      '[🟡 enqueueRequest] type=${request.runtimeType}, strategy=${request.strategy.policy}',
    );
    AppLogger.logOverlayShow(request);

    if (_activeRequest != null) {
      debugPrint('[🟠 Active exists → ${_activeRequest.runtimeType}]');

      final shouldReplace = OverlayConflictResolver.shouldReplaceCurrent(
        request,
        _activeRequest!,
      );
      final isSameType = request.runtimeType == _activeRequest.runtimeType;

      if (request.strategy.policy == OverlayReplacePolicy.dropIfSameType &&
          isSameType) {
        debugPrint('[🚫 Dropped: dropIfSameType]');
        return;
      }

      if (shouldReplace) {
        debugPrint('[♻️ Replacing current]');
        dismissCurrent();
      }
    }

    _removeDuplicateInQueue(request);
    _queue.add(_OverlayQueueItem(context: context, request: request));
    debugPrint('[➕ Added to queue] length = ${_queue.length}');
    _tryProcessQueue();
  }

  /// ▶️ Processes the first item in queue if no active entry.
  void _tryProcessQueue() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;

    final item = _queue.removeFirst();
    _activeRequest = item.request;
    final overlay = Overlay.of(item.context, rootOverlay: true);

    _activeEntry = OverlayEntry(
      builder:
          (ctx) => TapThroughOverlayBarrier(
            enablePassthrough: item.request.tapPassthroughEnabled,
            onTapOverlay: () {
              if (item.request.dismissPolicy ==
                  OverlayDismissPolicy.dismissible) {
                dismissCurrent();
              }
            },
            child: Builder(
              builder: (overlayCtx) => item.request.build(overlayCtx),
            ),
          ),
    );

    overlay.insert(_activeEntry!);
    AppLogger.logOverlayInserted(_activeRequest);
    debugPrint('[✅ Overlay inserted]');

    final delay = item.request.duration;
    if (delay > Duration.zero) {
      Future.delayed(delay, () async {
        await _dismissEntry();
        _isProcessing = false;
        _tryProcessQueue();
      });
    } else {
      _isProcessing = false;
    }
  }

  /// ❌ Dismisses current overlay and clears queue if needed.
  @override
  Future<void> dismissCurrent({bool clearQueue = false}) async {
    await _dismissEntry();
    if (clearQueue) _queue.clear();
  }

  /// 🧹 Internal: removes overlay from screen and resets state.
  Future<void> _dismissEntry() async {
    _activeEntry?.remove();
    _activeRequest?.onDismiss?.call();
    AppLogger.logOverlayDismiss(_activeRequest);
    _activeEntry = null;
    _activeRequest = null;
  }

  /// 🔁 Removes pending duplicates by type & category to avoid stacking
  void _removeDuplicateInQueue(OverlayUIEntry request) {
    _queue.removeWhere(
      (item) =>
          item.request.runtimeType == request.runtimeType &&
          item.request.strategy.category == request.strategy.category,
    );
  }

  /// ❌ Clears entire queue.
  @override
  void clearAll() => _queue.clear();

  /// ❌ Clears requests in queue for a specific context.
  @override
  void clearByContext(BuildContext context) {
    _queue.removeWhere((item) => item.context == context);
  }
}

/// 📦 Pairs overlay request with its context
final class _OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;
  const _OverlayQueueItem({required this.context, required this.request});
}
