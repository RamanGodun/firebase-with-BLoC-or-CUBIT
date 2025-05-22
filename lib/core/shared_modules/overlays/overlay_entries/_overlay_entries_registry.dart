import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart' show Uuid;
import '../core/overlay_core_types.dart';

part 'banner_overlay_entry.dart';
part 'dialog_overlay_entry.dart';
part 'snackbar_overlay_entry.dart';

/// 🧩 [OverlayUIEntry] — Abstract descriptor for a UI overlay entry
/// - Used in queue management and conflict resolution
/// - Holds config such as dismiss policy, priority, and platform-aware widget
/// - Each entry is uniquely identified by [id] (used to avoid duplicate insertion)
//--------------------------------------------------------------------------------

sealed class OverlayUIEntry {
  /// 🆔 Unique entry identifier (auto-generated via UUID if not provided)
  OverlayUIEntry({String? id}) : id = id ?? const Uuid().v4();
  final String id;

  /// 🎛️ Conflict resolution strategy: priority, replacement policy, category
  OverlayConflictStrategy get strategy;

  /// 🔓 Whether user can dismiss overlay via tap on background
  OverlayDismissPolicy? get dismissPolicy;

  /// ☁️ Whether overlay allows taps to pass through background
  bool get tapPassthroughEnabled => false;

  /// 🧱 Builds the overlay widget (platform-specific with animation engine inside)
  Widget buildWidget();

  /// 🧼 Called when overlay is auto-dismissed (e.g. timeout)
  void onAutoDismissed() {}

  ///
}
