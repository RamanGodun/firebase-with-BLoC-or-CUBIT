import 'dart:collection';
import 'package:flutter/material.dart';
import '../../loggers/_app_error_logger.dart';
import 'overlay_queue_item.dart';
import 'overlay_requests.dart';
import '../presentation/widgets/overlay_widget.dart';

/// 🎯 Centralized overlay dispatcher — entry point for all overlay requests
/// ✅ Enhanced OverlayDispatcher with strict one-at-a-time queue management
/// — Guarantees overlays show one by one, never overlapping.
//-------------------------------------------------------------

final class OverlayDispatcher {
  static final instance = OverlayDispatcher._();
  OverlayDispatcher._();

  final Queue<OverlayQueueItem> _queue = Queue();
  final Set<BuildContext> _activeContexts = {}; // For clearOnDispose
  bool _isProcessing = false;
  OverlayEntry? _activeEntry;
  OverlayAction? _activeRequest;

  /// 🧩 Enqueue an overlay request (guaranteed to be one-at-a-time)
  void enqueueRequest(BuildContext context, OverlayAction request) {
    AppErrorLogger.logOverlayShow(request);
    _activeContexts.add(context);
    _queue.add(OverlayQueueItem(context: context, request: request));
    _processQueue();
  }

  /// 🧼 Remove all pending overlays from queue
  void clearAll() {
    debugPrint('[OverlayDispatcher] clearAll()');
    _queue.clear();
  }

  /// 🧼 Remove all overlays tied to a specific context
  void clearByContext(BuildContext context) {
    _queue.removeWhere((e) => e.context == context);
    _activeContexts.remove(context);
  }

  /// 🚦 Internal queue processor — runs one-at-a-time
  void _processQueue() {
    if (_isProcessing || _queue.isEmpty) return;

    _isProcessing = true;
    final item = _queue.removeFirst();
    _executeRequest(item.context, item.request).whenComplete(() {
      _isProcessing = false;
      _processQueue();
    });
  }

  /// 🧩 Central dispatching per request type
  Future<void> _executeRequest(
    BuildContext context,
    OverlayAction request,
  ) async {
    try {
      await switch (request) {
        DialogOverlay(:final dialog) => showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => dialog,
        ),
        SnackbarOverlay(:final snackbar, :final duration) => _handleSnackbar(
          context,
          snackbar,
          duration,
        ),
        BannerOverlay(:final banner, :final duration) => _showOverlay(
          context,
          banner,
          duration,
        ),
        LoaderOverlay(:final loader, :final duration) => _showOverlay(
          context,
          loader,
          duration,
        ),
        CustomOverlay(:final widget, :final duration) => _showOverlay(
          context,
          widget,
          duration,
        ),
        ThemedBannerOverlay(:final message, :final icon) => _showOverlay(
          context,
          AnimatedOverlayWidget(message: message, icon: icon),
          request.duration,
        ),
      };
    } catch (e, st) {
      debugPrint('[OverlayDispatcher] Failed to render overlay: $e');
      debugPrint('[OverlayDispatcher] StackTrace: $st');
      // optionally log or fallback
    }
  }

  /// 🧱 Generic widget overlay
  Future<void> _showOverlay(
    BuildContext context,
    Widget widget,
    Duration duration,
  ) async {
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(builder: (_) => widget);
    _activeEntry = entry;
    _activeRequest = _queue.isNotEmpty ? _queue.first.request : null;

    overlay.insert(entry);
    await Future.delayed(duration);
    await _dismissEntry();
  }

  /// 🍞 Snackbar handler (for Android/iOS)
  Future<void> _handleSnackbar(
    BuildContext context,
    SnackBar snackbar,
    Duration duration,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(snackbar);
    await Future.delayed(duration);
  }

  /// 🚫 Closes the currently active overlay immediately.
  Future<void> dismissCurrent({bool clearQueue = false}) async {
    await _dismissEntry();
    if (clearQueue) _queue.clear();
  }

  /// 🧩 Closes the currently active overlay immediately.
  Future<void> _dismissEntry() async {
    AppErrorLogger.logOverlayDismiss(_activeRequest); // centralized logging
    _activeEntry?.remove();
    _activeEntry = null;
    _activeRequest = null;
  }

  ///
}
