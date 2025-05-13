import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/text_widget.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/general_extensions/_general_extensions.dart';
import '../../../../constants/_app_constants.dart';
import '../../overlay_dispatcher/conflicts_strategy/conflicts_strategy.dart';
import '../../overlay_presets/overlay_presets.dart';
import '../widgets/overlay_widget.dart';
import '../../core/overlay_message_key.dart';

part 'banners_overlay_entry.dart';
part 'custom_overlay_entry.dart';
part 'dialog_overlay_entry.dart';
part 'loader_overlay_entry.dart';
part 'snackbar_overlay_entry.dart';

/// 🎯 [OverlayUIEntry] — Sealed root type for all queued overlay UI requests
/// ✅ Used by dispatcher queue
/// ✅ Holds conflict strategy per entry type
/// ✅ Requires each implementation to provide [duration], [messageKey] and [strategy]
//--------------------------------------------------------------------------------

sealed class OverlayUIEntry {
  const OverlayUIEntry();

  /// 🕐 How long the overlay should stay on screen
  Duration get duration;

  /// 🏷️ Optional localization or identification key
  OverlayMessageKey? get messageKey => null;

  /// ⚖️ Strategy used by dispatcher to resolve enqueue/replace decisions
  OverlayConflictStrategy get strategy;
}

/// 🧱 Extension point — all entries must define their own rendering behavior
/// 📦 Dispatcher uses this to build overlay widgets
extension OverlayEntryBuilder on OverlayUIEntry {
  Widget buildWidget(BuildContext context) => switch (this) {
    DialogOverlayEntry e => e.build(),
    SnackbarOverlayEntry e => Builder(
      builder: (_) {
        ScaffoldMessenger.maybeOf(context)?.showSnackBar(e.snackbar);
        return const SizedBox.shrink();
      },
    ),
    BannerOverlayEntry e => e.banner,
    LoaderOverlayEntry e => e.loader,
    CustomOverlayEntry e => e.widget,
    ThemedBannerOverlayEntry e => e.build(),
  };
}
