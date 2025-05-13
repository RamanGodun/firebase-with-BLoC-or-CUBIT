import 'dart:collection';
import 'package:flutter/material.dart';
import '../presentation/overlay_entries/_overlay_entries.dart';
import '../presentation/tap_through_overlay_barrier.dart';
import 'conflicts_strategy/conflict_resolver.dart';
import 'conflicts_strategy/conflicts_strategy.dart';
import 'overlay_dispatcher_contract.dart';

// ✅ REFACTORED OverlayDispatcher with full conflict resolution logic
// ✅ Prevents duplicates
// ✅ Enforces Open/Closed Principle (no dispatcher logic changes needed)

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
    // 📌 Handle conflict with current active
    if (_activeRequest != null) {
      final shouldReplace = OverlayConflictResolver.shouldReplaceCurrent(
        request,
        _activeRequest!,
      );

      final isSameType = request.runtimeType == _activeRequest.runtimeType;
      final isSameKey =
          request.messageKey != null &&
          _activeRequest?.messageKey != null &&
          request.messageKey == _activeRequest!.messageKey;

      // 🛑 Drop if same type and key and policy = dropIfSameType
      if (request.strategy.policy == OverlayReplacePolicy.dropIfSameType &&
          isSameType &&
          isSameKey) {
        return;
      }

      // ✅ Replace current if allowed
      if (shouldReplace) {
        dismissCurrent();
      }
    }

    // 📌 Remove duplicates from queue (optional)
    _queue.removeWhere(
      (item) =>
          item.request.runtimeType == request.runtimeType &&
          item.request.messageKey != null &&
          item.request.messageKey == request.messageKey,
    );

    _queue.add(_OverlayQueueItem(context: context, request: request));
    _tryProcessQueue();
  }

  void _tryProcessQueue() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;

    final item = _queue.removeFirst();
    _activeRequest = item.request;
    final context = item.context;
    final overlay = Overlay.of(context, rootOverlay: true);

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
    overlay.insert(entry);

    if (item.request.duration > Duration.zero) {
      Future.delayed(item.request.duration, () async {
        await _dismissEntry();
        _isProcessing = false;
        _tryProcessQueue();
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
    _queue.removeWhere((item) => item.context == context);
  }
}

final class _OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;

  const _OverlayQueueItem({required this.context, required this.request});
}
