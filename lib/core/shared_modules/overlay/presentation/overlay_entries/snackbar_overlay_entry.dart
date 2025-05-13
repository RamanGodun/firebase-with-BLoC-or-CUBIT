part of '_overlay_entries.dart';

/// 🍞 [IOSSnackbarOverlayEntry] — iOS-styled snackbar entry using Cupertino-friendly design
//--------------------------------------------------------------------------------

final class IOSSnackbarOverlayEntry extends OverlayUIEntry {
  final String message;
  @override
  final OverlayMessageKey? messageKey;
  final OverlayUIPresets preset;
  final bool isError;
  final IconData? icon;

  const IOSSnackbarOverlayEntry(
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
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: props.margin,
          padding: props.contentPadding,
          decoration: BoxDecoration(
            color: props.color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon ?? props.icon, color: Colors.white),
              const SizedBox(width: 8),
              Flexible(
                child: TextWidget(
                  message,
                  TextType.bodyMedium,
                  color: Colors.white,
                  maxLines: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 🍞 [AndroidSnackbarOverlayEntry] — Android-styled snackbar using ScaffoldMessenger
//--------------------------------------------------------------------------------

final class AndroidSnackbarOverlayEntry extends OverlayUIEntry {
  final String message;
  @override
  final OverlayMessageKey? messageKey;
  final OverlayUIPresets preset;
  final bool isError;
  final IconData? icon;

  const AndroidSnackbarOverlayEntry(
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(icon ?? props.icon, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: TextWidget(
                  message,
                  TextType.bodyMedium,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: props.color,
          duration: props.duration,
          shape: props.shape,
          margin: props.margin,
          behavior: props.behavior,
        ),
      );
    });

    return const SizedBox.shrink();
  }
}
