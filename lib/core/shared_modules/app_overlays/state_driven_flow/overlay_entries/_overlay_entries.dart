import 'package:flutter/material.dart';
import '../../core/overlay_enums.dart';
import '../conflicts_strategy/conflicts_strategy.dart';

part 'banner_overlay_entry.dart';
part 'dialog_overlay_entry.dart';
part 'snackbar_overlay_entry.dart';

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

  /// 🎯 Make some actions after [OverlayUIEntry] dissmiss
  void onAutoDismissed() {}

  ///
}
