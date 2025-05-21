// import 'package:firebase_with_bloc_or_cubit/core/shared_modules/app_animation/target_platform_x.dart';
// import 'package:firebase_with_bloc_or_cubit/core/utils/extensions/context_extensions/_context_extensions.dart';
import 'package:flutter/material.dart';
// import '../../../../app_config/bootstrap/di_container.dart';
// import '../../../app_animation/animation_engines/__animation_engine_interface.dart';
// import '../../../app_animation/_animation_host.dart';
// import '../../../app_animation/animation_engines/__animation_engine_interface.dart';
// import '../../../app_animation/enums_for_animation_module.dart';
// import '../../presentation/widgets/android_banner.dart';
// import '../../presentation/widgets/ios_banner.dart';
// import '../../presentation/widgets/android_snackbar.dart';
// import '../../presentation/widgets/ios_dialog.dart';
// import '../../presentation/widgets/ios_snackbar.dart';
import '../../core/overlay_enums.dart';
import '../conflicts_strategy/conflicts_strategy.dart';
// import '../../presentation/widgets/android_dialog.dart';
// import '../overlay_dispatcher/overlay_dispatcher_interface.dart';

part 'dialog_overlay_entry.dart';
// part 'snackbar_overlay_entry.dart';
// part 'banner_overlay_entry.dart';

/// 🎯 [OverlayUIEntry] — Pure DTO for describing overlay behavior in overlay flow
/// ✅ Dispatcher uses this data to:
///    - Handle queueing and replacement logic
///    - Manage dismissibility and passthrough
//--------------------------------------------------------------------------------

sealed class OverlayUIEntry {
  const OverlayUIEntry();

  /// ⛓️ Overlay replacement policy, priority, and category
  OverlayConflictStrategy get strategy;

  /// 🔐 Can this overlay be dismissed via background tap
  OverlayDismissPolicy? get dismissPolicy;

  /// ☁️ Should taps pass through overlay background
  bool get tapPassthroughEnabled => false;

  /// 🧱 Builds the overlay widget for rendering
  Widget buildWidget();

  ///
}
