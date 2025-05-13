part of '_overlay_entries.dart';

/// 🍞 [SnackbarOverlayEntry] — Unified platform-aware snackbar entry
/// ✅ Queue entity for Dispatcher
/// ✅ Holds metadata (strategy, duration, key), not heavy UI
/// ✅ Delegates UI building to platform-specific widgets
//--------------------------------------------------------------------------------

final class SnackbarOverlayEntry extends OverlayUIEntry {
  final String message;
  @override
  final OverlayMessageKey? messageKey;
  final OverlayUIPresets preset;
  final bool isError;
  final IconData? icon;

  const SnackbarOverlayEntry(
    this.message, {
    this.messageKey,
    this.preset = const OverlayInfoUIPreset(),
    this.isError = false,
    this.icon,
  });

  @override
  Duration get duration => preset.resolve().duration;

  @override
  OverlayConflictStrategy get strategy => OverlayConflictStrategy(
    priority: isError ? OverlayPriority.critical : OverlayPriority.high,
    policy:
        isError
            ? OverlayReplacePolicy.forceReplace
            : OverlayReplacePolicy.forceIfLowerPriority,
    category: isError ? OverlayCategory.error : OverlayCategory.snackbar,
  );

  @override
  Widget build(BuildContext context) {
    final props = preset.resolve();

    return AppSnackbarWidget(
      message: message,
      icon: icon ?? props.icon,
      props: props,
      platform: context.platform,
    );
  }

  ///
}
