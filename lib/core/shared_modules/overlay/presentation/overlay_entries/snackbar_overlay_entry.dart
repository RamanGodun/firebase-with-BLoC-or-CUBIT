part of '_overlay_entries.dart';

/// 🍞 [SnackbarOverlayEntry] — Lightweight feedback overlay for transient messages
//--------------------------------------------------------------------------------

final class SnackbarOverlayEntry extends OverlayUIEntry {
  //
  final SnackBar snackbar;
  @override
  final OverlayMessageKey? messageKey;

  const SnackbarOverlayEntry(this.snackbar, {this.messageKey});

  /// 🏗️ Factory constructor with optional presets and icon customization
  factory SnackbarOverlayEntry.from(
    String message, {
    BuildContext? context,
    OverlayMessageKey? key,
    OverlayUIPresets preset = const OverlayErrorUIPreset(),
    IconData? icon,
  }) {
    final resolvedColor = context?.colorScheme.onPrimary ?? AppColors.white;
    final props = preset.resolve();

    return SnackbarOverlayEntry(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(3, 3, 3, 0),
        padding: props.contentPadding,
        shape: props.shape,
        duration: props.duration,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: SafeArea(
          top: true,
          bottom: false,
          left: true,
          right: true,
          child: Container(
            decoration: BoxDecoration(
              color: props.color.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon ?? props.icon,
                  color: props.color,
                ).withPaddingLeft(10),
                const SizedBox(width: 6),
                Expanded(
                  child: TextWidget(
                    message,
                    TextType.error,
                    color: resolvedColor,
                    isTextOnFewStrings: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      messageKey: key,
    );
  }

  @override
  Duration get duration => const Duration(seconds: 2);

  /// 🧠 Conflict strategy:
  /// — Replaces current overlay if it's lower-priority
  /// — Optimized for high-priority feedback that shouldn't be missed
  @override
  OverlayConflictStrategy get strategy => const OverlayConflictStrategy(
    priority: OverlayPriority.high,
    policy: OverlayReplacePolicy.forceIfLowerPriority,
    category: OverlayCategory.snackbar,
  );

  ///
}
