import 'dart:collection';
import 'package:flutter/material.dart';
import 'requests.dart';
import 'legacy/custom_animated_banner/overlay_widget.dart';

/// 🎯 Centralized overlay dispatcher — entry point for all overlay requests
/// ✅ Enhanced OverlayDispatcher with strict one-at-a-time queue management
/// — Guarantees overlays show one by one, never overlapping.
//-------------------------------------------------------------

final class OverlayDispatcher {
  static final instance = OverlayDispatcher._();
  OverlayDispatcher._();

  final Queue<_OverlayQueueItem> _queue = Queue();
  final Set<BuildContext> _activeContexts = {}; // For clearOnDispose
  bool _isProcessing = false;

  /// 🧩 Enqueue an overlay request (guaranteed to be one-at-a-time)
  void enqueueRequest(BuildContext context, OverlayRequest request) {
    _logOverlayShow(request);
    _activeContexts.add(context);
    _queue.add(_OverlayQueueItem(context: context, request: request));
    _processQueue();
  }

  /// 🧼 Remove all pending overlays from queue
  void clearAll() => _queue.clear();

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

  /// 🧪 Debug logging overlay key (if localized)
  void _logOverlayShow(OverlayRequest request) {
    final key = request.messageKey;
    if (key != null) debugPrint('[Overlay] Show: ${key.translationKey}');
  }

  /// 🧩 Central dispatching per request type
  Future<void> _executeRequest(BuildContext context, OverlayRequest request) =>
      switch (request) {
        DialogRequest(:final dialog) => showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => dialog,
        ),

        SnackbarRequest(:final snackbar, :final duration) => _handleSnackbar(
          context,
          snackbar,
          duration,
        ),

        BannerRequest(:final banner, :final duration) => _showOverlay(
          context,
          banner,
          duration,
        ),

        LoaderRequest(:final loader, :final duration) => _showOverlay(
          context,
          loader,
          duration,
        ),

        WidgetRequest(:final widget, :final duration) => _showOverlay(
          context,
          widget,
          duration,
        ),

        ThemeBannerRequest(:final message, :final icon) => _showOverlay(
          context,
          AnimatedOverlayWidget(message: message, icon: icon),
          request.duration,
        ),

        ///
      };

  /// 🧱 Generic widget overlay
  Future<void> _showOverlay(
    BuildContext context,
    Widget widget,
    Duration duration,
  ) async {
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(builder: (_) => widget);
    overlay.insert(entry);
    await Future.delayed(duration);
    entry.remove();
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
}

final class _OverlayQueueItem {
  final BuildContext context;
  final OverlayRequest request;
  const _OverlayQueueItem({required this.context, required this.request});
}
