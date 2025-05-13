part of '_overlay_entries.dart';

/// 💬 [DialogOverlayEntry] — Platform-adaptive modal dialog overlay
//--------------------------------------------------------------------------------

final class DialogOverlayEntry extends OverlayUIEntry {
  //
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final IconData? icon;
  final Color? color;

  const DialogOverlayEntry({
    required this.title,
    required this.content,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    this.icon,
    this.color,
  });

  @override
  Duration get duration => Duration.zero;

  /// 🧠 Conflict strategy:
  /// — Queued by default, non-intrusive
  /// — Dialog overlays do not interrupt active overlays
  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.normal,
    policy: OverlayReplacePolicy.waitQueue,
    category: OverlayCategory.dialog,
  );

  /// 🧱 Dialog builder method (used by dispatcher)
  Widget build() => AlertDialog(
    title: Row(
      children: [
        if (icon != null) Icon(icon, size: 24),
        if (icon != null) const SizedBox(width: 8),
        Text(title),
      ],
    ),
    content: Text(content),
    actions: [
      TextButton(onPressed: onCancel, child: Text(cancelText)),
      TextButton(onPressed: onConfirm, child: Text(confirmText)),
    ],
  );

  ///
}
