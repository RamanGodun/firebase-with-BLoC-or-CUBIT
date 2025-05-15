part of '_overlay_entries.dart';

/// 💬 [DialogOverlayEntry] — Overlay entry for platform-adaptive dialogs
/// - Acts as a configuration object for [OverlayDispatcher]
/// - Encapsulates conflict strategy, interaction callbacks, and style
/// - Builds a ready-to-render [AppDialog] widget
// ----------------------------------------------------------------------

final class DialogOverlayEntry extends OverlayUIEntry {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresets? preset; // 🎨 Optional style preset
  final bool isError; // ❗ Marks as an error (affects strategy and priority)
  final bool isInfoDialog;

  // 🔐 Dismiss policy (persistent or dismissible)
  @override
  final OverlayDismissPolicy dismissPolicy;

  const DialogOverlayEntry(
    this.title,
    this.content, {
    required this.confirmText,
    required this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.preset,
    this.isError = false,
    this.isInfoDialog = false,
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  /// ⏳ Dialogs don’t auto-dismiss (require explicit user interaction)
  @override
  Duration get duration => Duration.zero;

  /// ⚙️ Defines how this entry behaves in conflict scenarios
  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.normal,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.waitQueue,
    category: isError ? OverlayCategory.error : OverlayCategory.dialog,
  );

  /// 🏗️ Builds a platform-aware dialog widget with resolved props
  /// Called by Dispatcher during overlay insertion
  @override
  Widget build(BuildContext context) {
    final props = preset?.resolve() ?? const OverlayInfoUIPreset().resolve();

    return AppDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      presetProps: props,
      platform: context.platform,
      isInfoDialog: isInfoDialog,
    );
  }
}
