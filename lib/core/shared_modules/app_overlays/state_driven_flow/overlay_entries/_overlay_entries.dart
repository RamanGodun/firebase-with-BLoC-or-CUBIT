import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../app_config/bootstrap/di_container.dart';
import '../../../animation_engines/__animation_engine_interface.dart';
import '../../../animation_engines/_animation_engine_factory.dart';
import '../../../app_animation/_animation_host.dart';
import '../../presentation/widgets/app_banners.dart';
import '../../presentation/widgets/app_snackbar.dart';
import '../conflicts_strategy/conflicts_strategy.dart';
import '../../presentation/overlay_presets/overlay_presets.dart';
import '../../presentation/widgets/app_dialog.dart';
import '../overlay_dispatcher/overlay_dispatcher_interface.dart';

part 'dialog_overlay_entry.dart';
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
