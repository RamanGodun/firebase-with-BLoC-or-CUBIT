/*

import 'dart:collection';
import 'package:flutter/material.dart';
import '../presentation/overlay_entries/_overlay_entries.dart';
import '../presentation/tap_through_overlay_barrier.dart';
import 'conflicts_strategy/conflict_resolver.dart';
import 'conflicts_strategy/conflicts_strategy.dart';
import 'overlay_dispatcher_contract.dart';

final class OverlayDispatcher implements IOverlayDispatcher {
  OverlayDispatcher._();
  static final OverlayDispatcher _instance = OverlayDispatcher._();
  factory OverlayDispatcher() => _instance;

  final Queue<_OverlayQueueItem> _queue = Queue();
  OverlayEntry? _activeEntry;
  OverlayUIEntry? _activeRequest;
  bool _isProcessing = false;

  bool get canBeDismissedExternally =>
      _activeRequest?.dismissPolicy == OverlayDismissPolicy.dismissible;

  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) {
    final overlay = Overlay.of(context, rootOverlay: true);

    final shouldReplace =
        _activeRequest != null &&
        OverlayConflictResolver.shouldReplaceCurrent(request, _activeRequest!);

    final isDuplicate = _queue.any(
      (item) =>
          item.request.runtimeType == request.runtimeType &&
          item.request.messageKey != null &&
          request.messageKey != null &&
          item.request.messageKey == request.messageKey,
    );

    // 🛑 Drop if marked as dropIfSameType and duplicate is detected
    if (request.strategy.policy == OverlayReplacePolicy.dropIfSameType &&
        shouldReplace == false &&
        isDuplicate) {
      return;
    }

    if (shouldReplace) {
      dismissCurrent(clearQueue: true);
    }

    _queue.add(_OverlayQueueItem(overlay: overlay, request: request));
    _tryProcessQueue();
  }

  void _tryProcessQueue() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;

    final item = _queue.removeFirst();
    _activeRequest = item.request;

    final entry = OverlayEntry(
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

    _activeEntry = entry;
    item.overlay.insert(entry);

    if (item.request.duration > Duration.zero) {
      final entryRef = _activeEntry;
      final requestRef = _activeRequest;

      Future.delayed(item.request.duration, () async {
        if (_activeEntry == entryRef && _activeRequest == requestRef) {
          await _dismissEntry();
          _isProcessing = false;
          _tryProcessQueue();
        }
      });
    } else {
      _isProcessing = false;
    }
  }

  @override
  Future<void> dismissCurrent({bool clearQueue = false}) async {
    await _dismissEntry();
    if (clearQueue) _queue.clear();
  }

  Future<void> _dismissEntry() async {
    _activeEntry?.remove();
    _activeRequest?.onDismiss?.call();
    _activeEntry = null;
    _activeRequest = null;
  }

  @override
  void clearAll() => _queue.clear();

  @override
  void clearByContext(BuildContext context) {
    final overlay = Overlay.of(context, rootOverlay: true);
    _queue.removeWhere((item) => item.overlay == overlay);
  }
}

final class _OverlayQueueItem {
  final OverlayState overlay;
  final OverlayUIEntry request;

  const _OverlayQueueItem({required this.overlay, required this.request});
}

 */
