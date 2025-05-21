import 'dart:collection';
import 'package:flutter/material.dart';
import '../../../app_animation/animation_overlay_handler.dart';
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
  // 🔁 Controls animation lifecycle (binds to platform-specific engine)
  OverlayAnimationHandle? _activeHandle;
  // 🚦 Whether an overlay is currently being inserted
  bool _isProcessing = false;
  // Obtain  getter, that can interrupt user-driven overlays flow
  @override
  bool get isOverlayActive => _activeEntry != null;
  // 🔓 Whether the current overlay can be dismissed externally.
  @override
  bool get canBeDismissedExternally =>
      _activeRequest?.dismissPolicy == OverlayDismissPolicy.dismissible;

  /// 📥 Adds a new request to the queue, resolves replacement/drop strategy
  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) async {
    AppLogger.logOverlayShow(request);
    final overlay = Overlay.of(context, rootOverlay: true);

    if (_activeRequest != null) {
      AppLogger.logOverlayActiveExists(_activeRequest);

      // 🚫 Drop if strategy disallows same-type duplicates
      final isSameType =
          request.runtimeType == _activeRequest.runtimeType &&
          request.strategy.policy == OverlayReplacePolicy.dropIfSameType;

      if (isSameType) {
        AppLogger.logOverlayDroppedSameType();
        return;
      }

      // 🔁 Replace if conflict strategy allows
      final shouldReplace = OverlayPolicyResolver.shouldReplaceCurrent(
        request,
        _activeRequest!,
      );

      if (shouldReplace) {
        AppLogger.logOverlayReplacing();
        await dismissCurrent(force: true);
        _finalizeEnqueue(overlay, request);
        return;
      }
    }

    _finalizeEnqueue(overlay, request);
  }

  /// 🧱 Finalizes the enqueue logic after replacement/drop resolution
  void _finalizeEnqueue(OverlayState overlay, OverlayUIEntry request) {
    _removeDuplicateInQueue(request);
    _queue.add(_OverlayQueueItem(overlay: overlay, request: request));
    AppLogger.logOverlayAddedToQueue(_queue.length);
    _tryProcessQueue();
  }

  /// ▶️ Processes the first item in queue if no active entry.
  void _tryProcessQueue() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;

    final item = _queue.removeFirst();
    _activeRequest = item.request;

    // 🔁 Creates animation handle to externally control animation
    _activeHandle = OverlayAnimationHandle();

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

    item.overlay.insert(_activeEntry!);
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
  Future<void> dismissCurrent({
    bool clearQueue = false,
    bool force = false,
  }) async {
    await _dismissEntry(force: force);
    if (clearQueue) _queue.clear();
  }

  /// 🧹 Internal: removes entry, handles animation and resets state.
  Future<void> _dismissEntry({bool force = false}) async {
    if (_activeHandle != null) {
      try {
        await _activeHandle!.reverse(fast: force);
      } catch (_) {
        AppLogger.logOverlayDismissAnimationError(_activeRequest);
      }
    }

    _activeEntry?.remove();
    _activeRequest?.onDismiss?.call();
    AppLogger.logOverlayDismiss(_activeRequest);

    _activeEntry = null;
    _activeRequest = null;
    _activeHandle = null;
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

/// 📦 Internal data holder for enqueued overlays, binds [OverlayState] to a specific [OverlayUIEntry] request
final class _OverlayQueueItem {
  final OverlayState overlay;
  final OverlayUIEntry request;

  const _OverlayQueueItem({required this.overlay, required this.request});
}
