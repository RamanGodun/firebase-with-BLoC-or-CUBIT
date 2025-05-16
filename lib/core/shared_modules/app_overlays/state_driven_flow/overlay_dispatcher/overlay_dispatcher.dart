import 'dart:collection';
import 'package:flutter/material.dart';
import '../../../app_loggers/_app_error_logger.dart';
import '../overlay_entries/_overlay_entries.dart';
import '../../core/tap_through_overlay_barrier.dart';
import '../conflicts_strategy/police_resolver.dart';
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

  // 📦 Queue to hold pending overlay requests
  final Queue<_OverlayQueueItem> _queue = Queue();
  // 🎯 Currently visible overlay entry in the widget tree
  OverlayEntry? _activeEntry;
  // 📄 Metadata of the currently shown overlay (used for decisions)
  OverlayUIEntry? _activeRequest;
  // 🚦 Whether an overlay is currently being inserted
  bool _isProcessing = false;
  // Obtain  getter, that can interrupt user-driven overlays flow
  @override
  bool get isOverlayActive => _activeEntry != null;
  // 🔓 Whether the current overlay can be dismissed externally.
  @override
  bool get canBeDismissedExternally =>
      _activeRequest?.dismissPolicy == OverlayDismissPolicy.dismissible;

  /// 📥 Adds a new request to the queue, resolves conflicts if needed.
  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) {
    AppLogger.logOverlayShow(request);
    // If a current overlay exists, resolves replacement or skips duplicate.
    if (_activeRequest != null) {
      AppLogger.logOverlayActiveExists(_activeRequest);
      final shouldReplace = OverlayPolicyResolver.shouldReplaceCurrent(
        request,
        _activeRequest!,
      );
      final isSameType = request.runtimeType == _activeRequest.runtimeType;
      if (request.strategy.policy == OverlayReplacePolicy.dropIfSameType &&
          isSameType) {
        AppLogger.logOverlayDroppedSameType();
        return;
      }
      if (shouldReplace) {
        AppLogger.logOverlayReplacing();
        dismissCurrent();
      }
    }
    _removeDuplicateInQueue(request);
    // Adds new item to the queue and starts processing if idle.
    _queue.add(_OverlayQueueItem(context: context, request: request));
    AppLogger.logOverlayAddedToQueue(_queue.length);
    _tryProcessQueue();
  }

  /// ▶️ Processes the first item in queue if no active entry.
  void _tryProcessQueue() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;
    final item = _queue.removeFirst();
    _activeRequest = item.request;
    final overlay = Overlay.of(item.context, rootOverlay: true);
    // Inserts new OverlayEntry with tap-through barrier.
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
    // Automatically schedules dismissal after [duration].
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

  //
}

/// 📦 Internal data holder for enqueued overlays, binds [BuildContext] to a specific [OverlayUIEntry] request
final class _OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;

  const _OverlayQueueItem({required this.context, required this.request});
}
