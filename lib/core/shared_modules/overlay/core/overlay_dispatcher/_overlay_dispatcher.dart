import 'dart:collection';
import 'package:flutter/material.dart';
import '../../../loggers/_app_error_logger.dart';
import 'overlay_dispatcher_contract.dart';
import '../overlay_queue_item.dart';
import '../overlay_types.dart';
import '../../presentation/widgets/overlay_widget.dart';

/// 🎯 [OverlayDispatcher] — Centralized singleton overlay queue manager
/// ✅ Ensures overlays (SnackBars, Banners, Dialogs) are shown one-at-a-time
/// 🧠 Works with fallback timeout and internal cleanup
/// — Guarantees overlays show one by one, never overlapping.
//-------------------------------------------------------------

final class OverlayDispatcher implements IOverlayDispatcher {
  static final _shared = OverlayDispatcher._();

  /// 🏗️ Factory to ensure singleton usage via DI
  factory OverlayDispatcher() => _shared;
  OverlayDispatcher._();

  final Queue<OverlayQueueItem> _queue = Queue();
  final Set<BuildContext> _activeContexts = {}; // 📍 For per-context clearing
  bool _isProcessing = false;
  OverlayEntry? _activeEntry;
  OverlayUIEntry? _activeRequest;

  /// 🧩 Adds a request to the queue and initiates processing if idle
  @override
  void enqueueRequest(BuildContext context, OverlayUIEntry request) {
    AppErrorLogger.logOverlayShow(request);
    _activeContexts.add(context);
    _queue.add(OverlayQueueItem(context: context, request: request));
    _processQueue();
  }

  /// 🧼 Clears all overlay requests from the queue
  @override
  void clearAll() {
    debugPrint('[OverlayDispatcher] clearAll()');
    _queue.clear();
  }

  /// 🧼 Clears overlay requests for a specific [context]
  @override
  void clearByContext(BuildContext context) {
    _queue.removeWhere((e) => e.context == context);
    _activeContexts.remove(context);
  }

  /// 🚦 Internal: Processes the overlay queue one-by-one with timeout fallback
  void _processQueue() {
    if (_isProcessing || _queue.isEmpty) return;

    _isProcessing = true;
    final item = _queue.removeFirst();

    Future.any([
      _executeRequest(item.context, item.request),
      Future.delayed(const Duration(seconds: 10)), // ⏱ Timeout fallback
    ]).whenComplete(() {
      _isProcessing = false;
      _processQueue();
    });
  }

  /// 🔀 Handles the dispatching logic for each type of [OverlayType]
  Future<void> _executeRequest(
    BuildContext context,
    OverlayUIEntry request,
  ) async {
    try {
      await switch (request) {
        DialogOverlayEntry(:final dialog) => showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (_) => dialog,
        ),
        SnackbarOverlayEntry(:final snackbar, :final duration) =>
          _handleSnackbar(context, snackbar, duration),
        BannerOverlayEntry(:final banner, :final duration) => _showOverlay(
          context,
          banner,
          duration,
        ),
        LoaderOverlayEntry(:final loader, :final duration) => _showOverlay(
          context,
          loader,
          duration,
        ),
        CustomOverlayEntry(:final widget, :final duration) => _showOverlay(
          context,
          widget,
          duration,
        ),
        ThemedBannerOverlayEntry(:final message, :final icon) => _showOverlay(
          context,
          AnimatedOverlayWidget(message: message, icon: icon),
          request.duration,
        ),
      };
    } catch (e, st) {
      debugPrint('[OverlayDispatcher] Failed to render overlay: $e');
      debugPrint('[OverlayDispatcher] StackTrace: $st');
    }
  }

  /// 📦 Shows generic widget inside Overlay and dismisses after [duration]
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

  /// 🍞 Shows [SnackBar] and delays continuation
  Future<void> _handleSnackbar(
    BuildContext context,
    SnackBar snackbar,
    Duration duration,
  ) async {
    final messenger = ScaffoldMessenger.maybeOf(context);
    messenger?.showSnackBar(snackbar);
    await Future.delayed(duration);
  }

  /// 🚫 Dismisses current overlay; optionally clears queue
  @override
  Future<void> dismissCurrent({bool clearQueue = false}) async {
    await _dismissEntry();
    if (clearQueue) _queue.clear();
  }

  /// 🔻 Removes active overlay entry and resets internal state
  Future<void> _dismissEntry() async {
    AppErrorLogger.logOverlayDismiss(_activeRequest);
    _activeEntry?.remove();
    _activeEntry = null;
    _activeRequest = null;
  }

  ///
}
