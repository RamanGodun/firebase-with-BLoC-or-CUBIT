import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import '../../loggers/_app_error_logger.dart';
import 'conflicts_strategy/conflict_resolver.dart';
import 'conflicts_strategy/conflicts_strategy.dart';
import 'overlay_dispatcher_contract.dart';
import '../presentation/overlay_entries/_overlay_entries.dart';
import '../presentation/tap_through_overlay_barrier.dart';

/// 🎯 [OverlayDispatcher] — Centralized singleton overlay queue manager
/// ✅ Platform-agnostic, decoupled from overlay UI implementations
/// ✅ Resolves conflicts via [OverlayConflictStrategy]
/// ✅ Supports timeouts and context-aware cleanup
//-------------------------------------------------------------

final class OverlayDispatcher implements IOverlayDispatcher {
  static final _shared = OverlayDispatcher._();

  /// 🏗️ Factory to ensure singleton usage via DI
  factory OverlayDispatcher() => _shared;
  OverlayDispatcher._();

  final Queue<OverlayQueueItem> _queue = Queue();

  /// 📍 Used for per-context clearByContext
  final Set<BuildContext> _activeContexts = {};

  /// 🧠 For built-in throttling
  final Map<Type, DateTime> _lastRequestTimestamps = {};

  /// 🚦 Flag to prevent overlapping overlays
  bool _isProcessing = false;

  /// 🟡 Currently displayed OverlayEntry
  OverlayEntry? _activeEntry;

  /// 🧠 Currently active logical request for conflict strategy & logging
  OverlayUIEntry? _activeRequest;

  /// 💾 Used for re-firing enqueued request after dismiss
  OverlayQueueItem? _pendingRequestAfterDismiss;
  //
  bool get isActiveDismissible =>
      _activeRequest?.dismissPolicy != OverlayDismissPolicy.persistent;
  static const _minIntervalBetweenSameType = Duration(milliseconds: 150);

  /// 🧩 Public API — adds overlay request to queue with conflict strategy check
  /// ✳️ If there's an active overlay, checks whether new one should replace it.
  /// ✳️ If not allowed and not `waitQueue`, request is silently dropped.
  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) {
    // 🚧 Skip if same type request came too soon
    final lastShown = _lastRequestTimestamps[request.runtimeType];
    if (lastShown != null &&
        DateTime.now().difference(lastShown) < _minIntervalBetweenSameType) {
      debugPrint('[OverlayDispatcher] Throttled: ${request.runtimeType}');
      return;
    }
    _lastRequestTimestamps[request.runtimeType] = DateTime.now();

    AppErrorLogger.logOverlayShow(request);
    _activeContexts.add(context);

    if (_activeRequest != null) {
      if (OverlayConflictResolver.shouldReplaceCurrent(
        request,
        _activeRequest!,
      )) {
        _pendingRequestAfterDismiss = OverlayQueueItem(
          context: context,
          request: request,
        );
        _queue.clear();
        _dismissEntry(); // 🔄 Change the active one
        return;
      } else if (!OverlayConflictResolver.shouldWait(request)) {
        return; // ❌ Drop if not allowed
      }
    }

    // 🧹 Очистити чергу від запитів того ж типу (тільки останній виживає)
    _queue.removeWhere((e) => e.request.runtimeType == request.runtimeType);

    _queue.add(OverlayQueueItem(context: context, request: request));
    _processQueue();
  }

  /// 🚦 Queue processor — ensures one-by-one execution with fallback timeout
  void _processQueue() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;
    final item = _queue.removeFirst();

    final completer = Completer<void>();
    bool isRendered = false;

    _renderEntry(item.context, item.request).then((_) {
      isRendered = true;
      completer.complete();
    });

    _handleTimeout(isRendered, completer);

    completer.future.whenComplete(() {
      _isProcessing = false;
      _handlePendingRequestAfterDismiss();
      _processQueue();
    });
  }

  /// ⏳ Timeout fallback if render takes too long
  void _handleTimeout(bool isRendered, Completer<void> completer) {
    Future.delayed(const Duration(seconds: 10)).then((_) {
      if (!isRendered && !completer.isCompleted) {
        debugPrint('[OverlayDispatcher] Timeout fallback triggered');
        _dismissEntry();
        completer.complete();
      }
    });
  }

  /// 🔁 Enqueues deferred request if present
  void _handlePendingRequestAfterDismiss() {
    if (_pendingRequestAfterDismiss case final item?) {
      _queue.add(item);
      _pendingRequestAfterDismiss = null;
    }
  }

  /// 🖼️ Builds and shows overlay
  Future<void> _renderEntry(BuildContext context, OverlayUIEntry entry) async {
    try {
      final widget = entry.build(context);
      final duration = entry.duration;
      await _showOverlay(context, widget, duration, entry);
    } catch (e, st) {
      debugPrint('[OverlayDispatcher] Error: $e');
      debugPrint('$st');
    }
  }

  /// 📦 Inserts overlay in UI and starts auto-dismiss timer
  Future<void> _showOverlay(
    BuildContext context,
    Widget widget,
    Duration duration,
    OverlayUIEntry request,
  ) async {
    final overlay = Overlay.of(context, rootOverlay: true);
    if (!context.mounted) return;

    final entryWidget = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            TapThroughOverlayBarrier(
              enablePassthrough: request.tapPassthroughEnabled,
              onTapOverlay: () {
                if (request.dismissPolicy == OverlayDismissPolicy.dismissible) {
                  dismissCurrent();
                }
              },
              child: widget,
            ),
          ],
        );
      },
    );

    _activeEntry = entryWidget;
    _activeRequest = request;
    overlay.insert(entryWidget);

    if (duration > Duration.zero) {
      await Future.delayed(duration);
      await _dismissEntry();
    }
  }

  /// ❌ Public API to dismiss current overlay (with optional queue clear)
  @override
  Future<void> dismissCurrent({bool clearQueue = false}) async {
    if (!isActiveDismissible) return;
    await _dismissEntry();
    if (clearQueue) _queue.clear();
  }

  /// 🧹 Cleanup of active overlay
  Future<void> _dismissEntry() async {
    AppErrorLogger.logOverlayDismiss(_activeRequest);
    _activeEntry?.remove();
    _activeRequest?.onDismiss?.call();
    _activeEntry = null;
    _activeRequest = null;
  }

  /// 🧼 Clears all pending overlay requests
  @override
  void clearAll() {
    debugPrint('[OverlayDispatcher] clearAll()');
    _queue.clear();
  }

  /// 🧼 Clears requests for a specific context
  @override
  void clearByContext(BuildContext context) {
    _queue.removeWhere((e) => e.context == context);
    _activeContexts.remove(context);
  }
}

/// 📦 Wrapper for context + overlay request
final class OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;
  const OverlayQueueItem({required this.context, required this.request});
}
