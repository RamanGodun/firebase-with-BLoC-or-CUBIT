import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_with_bloc_or_cubit/core/shared_presentation/shared_widgets/text_widget.dart';
import '../../overlay_dispatcher/conflicts_strategy/conflicts_strategy.dart';
import '../overlay_presets/overlay_presets.dart';
import '../widgets/overlay_widget.dart';
import '../../core/overlay_message_key.dart';

part 'custom_overlay_entry.dart';
part 'dialog_overlay_entry.dart';
part 'loader_overlay_entry.dart';
part 'snackbar_overlay_entry.dart';
part 'banner_ios.dart';
part 'banner_android.dart';

/// 🎯 [OverlayUIEntry] — Sealed root type for all queued overlay UI requests
/// ✅ Used by dispatcher queue
/// ✅ Holds conflict strategy per entry type
/// ✅ Requires each implementation to provide [duration], [messageKey] and [strategy]
//--------------------------------------------------------------------------------

/// 🎯 [OverlayUIEntry] — Sealed base class for queued overlay entries
/// ✅ Each entry must implement: [duration], [messageKey], [strategy], [build(context)]
//--------------------------------------------------------------------------------
sealed class OverlayUIEntry {
  const OverlayUIEntry();

  /// 🕐 How long the overlay stays on screen (if not dismissed manually)
  Duration get duration;

  /// 🏷️ Optional localization/translation key (used for deduplication or i18n)
  OverlayMessageKey? get messageKey => null;

  /// ⚖️ Conflict strategy (used to resolve priority/collision in queue)
  OverlayConflictStrategy get strategy;

  /// 🖼️ Widget builder — always called by the dispatcher
  Widget build(BuildContext context);
}
