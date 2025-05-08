import 'dart:collection';
import 'package:flutter/material.dart';
import '_overlay_request.dart';

/// 🎯 Centralized overlay dispatcher — entry point for all overlay requests
//-------------------------------------------------------------
final class OverlayDispatcher {
  static final instance = OverlayDispatcher._();
  OverlayDispatcher._();

  final Queue<_OverlayQueueItem> _queue = Queue();
  final Set<BuildContext> _activeContexts = {}; // For clearOnDispose
  bool _isProcessing = false;

  void enqueueRequest(BuildContext context, OverlayRequest request) {
    _logOverlayShow(request);
    _activeContexts.add(context);
    _queue.add(_OverlayQueueItem(context: context, request: request));
    _processQueue();
  }

  void clearAll() => _queue.clear();

  void clearByContext(BuildContext context) {
    _queue.removeWhere((e) => e.context == context);
    _activeContexts.remove(context);
  }

  void _processQueue() {
    if (_isProcessing || _queue.isEmpty) return;

    _isProcessing = true;
    final item = _queue.removeFirst();
    _executeRequest(item.context, item.request).whenComplete(() {
      _isProcessing = false;
      _processQueue();
    });
  }

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
      };

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

  Future<void> _handleSnackbar(
    BuildContext context,
    SnackBar snackbar,
    Duration duration,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(snackbar);
    await Future.delayed(duration);
  }

  void _logOverlayShow(OverlayRequest request) {
    final messageKey = switch (request) {
      SnackbarRequest(:final messageKey) => messageKey,
      _ => null,
    };
    if (messageKey != null) {
      debugPrint('[Overlay] Show: ${messageKey.translationKey}');
    }
  }

  ///
}

final class _OverlayQueueItem {
  final BuildContext context;
  final OverlayRequest request;
  const _OverlayQueueItem({required this.context, required this.request});
}
