part of '_overlay_entries.dart';

/// 💬 [DialogOverlayEntry] — Unified platform-aware dialog entry
//--------------------------------------------------------------------------------
final class DialogOverlayEntry extends OverlayUIEntry {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresets? preset;
  final bool isError;
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
    this.dismissPolicy = OverlayDismissPolicy.dismissible,
  });

  @override
  Duration get duration => Duration.zero;

  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.normal,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.waitQueue,
    category: isError ? OverlayCategory.error : OverlayCategory.dialog,
  );

  @override
  Widget build(BuildContext context) {
    final props = preset?.resolve();
    return AppDialog(
      title: title,
      content: content,
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      presetProps: props,
      platform: context.platform,
    );
  }

  ///
}
