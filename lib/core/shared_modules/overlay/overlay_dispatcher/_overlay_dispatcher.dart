import 'dart:collection';
import 'package:flutter/material.dart';
import '../../loggers/_app_error_logger.dart';
import 'conflicts_strategy/conflicts_strategy.dart';
import 'overlay_dispatcher_contract.dart';
import '../presentation/overlay_entries/_overlay_entries.dart';

/// 🎯 [OverlayDispatcher] — Centralized singleton overlay queue manager
/// ✅ Ensures overlays (SnackBars, Banners, Dialogs) are shown one-at-a-time
/// ✅ Supports conflict resolution via [OverlayConflictStrategy]
/// ✅ Uses widget-based rendering to support Open/Closed principle
/// ✅ Includes fallback timeout and proper cleanup
//-------------------------------------------------------------

final class OverlayDispatcher implements IOverlayDispatcher {
  static final _shared = OverlayDispatcher._();

  /// 🏗️ Factory to ensure singleton usage via DI
  factory OverlayDispatcher() => _shared;
  OverlayDispatcher._();

  final Queue<OverlayQueueItem> _queue = Queue();

  /// 📍 Used for per-context clearByContext
  final Set<BuildContext> _activeContexts = {};

  /// 🚦 Flag to prevent overlapping overlays
  bool _isProcessing = false;

  /// 🟡 Currently displayed OverlayEntry
  OverlayEntry? _activeEntry;

  /// 🧠 Currently active logical request for conflict strategy & logging
  OverlayUIEntry? _activeRequest;
  //

  /// 🧩 Public API — adds overlay request to queue with conflict strategy check
  /// ✳️ If there's an active overlay, checks whether new one should replace it.
  /// ✳️ If not allowed and not `waitQueue`, request is silently dropped.
  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) {
    AppErrorLogger.logOverlayShow(request);
    _activeContexts.add(context);
    if (_activeRequest != null) {
      final shouldReplace = _shouldReplaceCurrent(request, _activeRequest!);
      if (shouldReplace) {
        _dismissEntry(); // 🔄 Replace current overlay
      } else if (!_shouldWait(request)) {
        return; // ❌ Drop new request if not allowed
      }
    }
    _queue.add(OverlayQueueItem(context: context, request: request));
    _processQueue();
  }

  /// 🚦 Queue processor — ensures one-by-one execution with fallback timeout
  /// ✳️ If overlay hangs beyond 10 seconds, fallback proceeds with cleanup.
  void _processQueue() {
    if (_isProcessing || _queue.isEmpty) return;
    _isProcessing = true;
    final item = _queue.removeFirst();

    Future.any([
      _renderEntry(item.context, item.request),
      Future.delayed(const Duration(seconds: 10)),
    ]).whenComplete(() {
      _isProcessing = false;
      _processQueue(); // 🔁 Process next in queue
    });
  }

  /// 🖼️ Uses Open/Closed-compatible method to delegate build/render logic
  Future<void> _renderEntry(BuildContext context, OverlayUIEntry entry) async {
    try {
      final widget = entry.buildWidget(context);
      final duration = entry.duration;
      await _showOverlay(context, widget, duration);
    } catch (e, st) {
      debugPrint('[OverlayDispatcher] Error: $e');
      debugPrint('$st');
    }
  }

  /// 📦 Shows widget in overlay for given [duration], then cleans up
  Future<void> _showOverlay(
    BuildContext context,
    Widget widget,
    Duration duration,
  ) async {
    final overlay = Overlay.of(context, rootOverlay: true);
    if (!context.mounted) return;

    final entry = OverlayEntry(builder: (_) => widget);
    _activeEntry = entry;
    _activeRequest = _queue.isNotEmpty ? _queue.first.request : null;

    overlay.insert(entry);
    await Future.delayed(duration);
    await _dismissEntry();
  }

  /// ❌ Public API to dismiss current overlay (with optional queue clear)
  @override
  Future<void> dismissCurrent({bool clearQueue = false}) async {
    await _dismissEntry();
    if (clearQueue) _queue.clear();
  }

  /// 🧹 Internal cleanup for current active overlay entry
  Future<void> _dismissEntry() async {
    AppErrorLogger.logOverlayDismiss(_activeRequest);
    _activeEntry?.remove();
    _activeEntry = null;
    _activeRequest = null;
  }

  /// 🤝 Determines if [next] request is allowed to replace [current] request
  bool _shouldReplaceCurrent(OverlayUIEntry next, OverlayUIEntry current) {
    final n = next.strategy;
    final c = current.strategy;

    return switch (n.policy) {
      OverlayReplacePolicy.forceReplace => true,
      OverlayReplacePolicy.forceIfSameCategory => n.category == c.category,
      OverlayReplacePolicy.forceIfLowerPriority =>
        n.priority.index > c.priority.index,
      OverlayReplacePolicy.waitQueue => false,
    };
  }

  /// ⏳ Used to determine if request should be queued instead of dropped
  bool _shouldWait(OverlayUIEntry next) =>
      next.strategy.policy == OverlayReplacePolicy.waitQueue;

  /// 🧼 Removes all pending overlay requests from queue
  @override
  void clearAll() {
    debugPrint('[OverlayDispatcher] clearAll()');
    _queue.clear();
  }

  /// 🧼 Clears queued overlays specific to [context]
  @override
  void clearByContext(BuildContext context) {
    _queue.removeWhere((e) => e.context == context);
    _activeContexts.remove(context);
  }

  ///
}

///

final class OverlayQueueItem {
  final BuildContext context;
  final OverlayUIEntry request;
  const OverlayQueueItem({required this.context, required this.request});
}
