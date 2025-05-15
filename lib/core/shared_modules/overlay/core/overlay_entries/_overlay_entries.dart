import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../conflicts_strategy/conflicts_strategy.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/widgets/app_banner.dart';
import '../../presentation/widgets/app_dialog.dart';
import '../../presentation/widgets/app_loader.dart';
import '../../presentation/widgets/app_snackbar.dart';
import '../../presentation/widgets/app_custom_overlay.dart';

part 'custom_overlay_entry.dart';
part 'dialog_overlay_entry.dart';
part 'loader_overlay_entry.dart';
part 'snackbar_overlay_entry.dart';
part 'banner_overlay_entry.dart';

/// 🎯 [OverlayUIEntry] — Sealed base class for queued overlay entries
/// ✅ Each entry must implement: [duration], [messageKey], [strategy], [build(context)]
//--------------------------------------------------------------------------------

sealed class OverlayUIEntry {
  const OverlayUIEntry();

  /// 🕐 How long the overlay stays on screen (if not dismissed manually)
  Duration get duration;

  /// ⚖️ Conflict strategy (used to resolve priority/collision in queue)
  OverlayConflictStrategy get strategy;

  /// 🖼️ Widget builder — always called by the dispatcher
  Widget build(BuildContext context);

  /// 🧼 Optional dismiss callback
  VoidCallback? get onDismiss => null;

  /// 🆕 Whether GlobalOverlayHandler can dismiss this overlay
  OverlayDismissPolicy get dismissPolicy;

  ///
  bool get tapPassthroughEnabled => false;

  ///
}
