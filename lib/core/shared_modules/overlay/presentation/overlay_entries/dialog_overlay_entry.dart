part of '_overlay_entries.dart';

/// 💬 iOS Dialog Overlay Entry
//--------------------------------------------------------------------------------

final class IOSDialogOverlayEntry extends OverlayUIEntry {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresets? preset;
  final bool isError;

  const IOSDialogOverlayEntry(
    this.title,
    this.content, {
    required this.confirmText,
    required this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.preset,
    this.isError = false,
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
    return AlertDialog(
      shape: props?.shape,
      title: Row(
        children: [
          if (props?.icon != null) Icon(props!.icon, size: 24),
          if (props?.icon != null) const SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: [
        TextButton(onPressed: onCancel, child: Text(cancelText)),
        TextButton(onPressed: onConfirm, child: Text(confirmText)),
      ],
    );
  }
}

///  💬 Android Dialog Overlay Entry
//--------------------------------------------------------------------------------

final class AndroidDialogOverlayEntry extends OverlayUIEntry {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final OverlayUIPresets? preset;
  final bool isError;

  const AndroidDialogOverlayEntry(
    this.title,
    this.content, {
    required this.confirmText,
    required this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.preset,
    this.isError = false,
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
    return AlertDialog(
      shape: props?.shape,
      backgroundColor: props?.color,
      title: Row(
        children: [
          if (props?.icon != null) Icon(props!.icon, size: 24),
          if (props?.icon != null) const SizedBox(width: 8),
          Text(title),
        ],
      ),
      content: Text(content),
      actions: [
        TextButton(onPressed: onCancel, child: Text(cancelText)),
        TextButton(onPressed: onConfirm, child: Text(confirmText)),
      ],
    );
  }
}
