part of '_overlay_entries.dart';

/// 💬 [DialogOverlayEntry] — State-driven platform-aware dialog
/// - Used by [OverlayDispatcher] for error/info dialogs from state
/// - Defines conflict strategy, priority, and interactivity
/// - Uses [AnimationHost] for transitions and cleanup
/// - Called by Dispatcher during overlay insertion
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

  /// 🧱 Builds and animates the dialog via [AnimationHost]
  /// 🧱 Builds and animates the dialog via [AnimationHost]
  @override
  Widget build(BuildContext context) {
    //
    /// Internally resolves props
    final props = preset?.resolve() ?? const OverlayInfoUIPreset().resolve();

    // Selects [AnimationPlatform] (iOS/Android)
    final animationPlatform = context.platform.toAnimationPlatform();

    /// [AnimationHost] invokes [engine.play] and handles cleanup
    return AnimationHost(
      overlayType: UserDrivenOverlayType.dialog,
      displayDuration: duration,
      platform: animationPlatform,
      onDismiss: onDismiss,

      /// 🎯 Builds the dialog widget with platform-specific animation engine
      builderWithEngine:
          (engine) => switch (animationPlatform) {
            AnimationPlatform.ios || AnimationPlatform.adaptive => IOSAppDialog(
              title: title,
              content: content,
              confirmText: confirmText,
              cancelText: cancelText,
              onConfirm: onConfirm,
              onCancel: onCancel,
              presetProps: props,
              isInfoDialog: isInfoDialog,
              isFromUserFlow: false,
              engine: engine,
            ),
            AnimationPlatform.android => AndroidDialog(
              title: title,
              content: content,
              confirmText: confirmText,
              cancelText: cancelText,
              onConfirm: onConfirm,
              onCancel: onCancel,
              presetProps: props,
              isInfoDialog: isInfoDialog,
              isFromUserFlow: false,
              engine: engine,
            ),
          },
    );
  }

  //
}
