// overlay_tasks.dart
import 'package:flutter/material.dart';

/// 🧩 Base class for all overlay-related tasks
//-------------------------------------------------------------

abstract class OverlayTask {
  final BuildContext context;
  const OverlayTask(this.context);

  Duration get duration => const Duration(seconds: 2);
  Future<void> execute();
}

/// 🎭 Custom animated widget overlay task
//-------------------------------------------------------------

class OverlayWidgetTask extends OverlayTask {
  final Widget widget;
  OverlayWidgetTask(super.context, this.widget);

  @override
  Future<void> execute() async {
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(builder: (_) => widget);
    overlay.insert(entry);
    await Future.delayed(duration);
    entry.remove();
  }
}

/// 💬 Platform adaptive dialog task
class OverlayDialogTask extends OverlayTask {
  final Widget dialog;
  OverlayDialogTask(super.context, this.dialog);

  @override
  Future<void> execute() => showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (_) => dialog,
  );
}

/// 🍞 Snackbar task for Android/iOS
class OverlaySnackbarTask extends OverlayTask {
  final String message;
  OverlaySnackbarTask(super.context, this.message);

  @override
  Future<void> execute() async {
    final scaffold = ScaffoldMessenger.maybeOf(context);
    if (scaffold != null) {
      scaffold.showSnackBar(SnackBar(content: Text(message)));
      await Future.delayed(duration);
    }
  }
}

/// 🪧 Banner task for success/info/etc overlays
class OverlayBannerTask extends OverlayTask {
  final Widget banner;
  OverlayBannerTask(super.context, this.banner);

  @override
  Future<void> execute() async {
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(builder: (_) => banner);
    overlay.insert(entry);
    await Future.delayed(duration);
    entry.remove();
  }
}

/// ⏳ Loading indicator overlay task
class OverlayLoadingIndicatorTask extends OverlayTask {
  final Widget loader;
  OverlayLoadingIndicatorTask(super.context, this.loader);

  @override
  Future<void> execute() async {
    final overlay = Overlay.of(context, rootOverlay: true);
    final entry = OverlayEntry(builder: (_) => loader);
    overlay.insert(entry);
    await Future.delayed(duration);
    entry.remove();
  }
}
