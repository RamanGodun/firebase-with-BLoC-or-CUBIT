import 'package:flutter/material.dart' show OverlayState;
import '../overlay_entries/_overlay_entries_registry.dart';

/// 📦 [OverlayQueueItem] — Internal holder for enqueued overlays.
/// ✅ Binds [OverlayState] with a specific [OverlayUIEntry] for insertion.
final class OverlayQueueItem {
  final OverlayState overlay;
  final OverlayUIEntry request;
  const OverlayQueueItem({required this.overlay, required this.request});
}

/// 🎯 Defines core strategy types for overlay conflict resolution,
/// used to determine behavior when multiple overlays are triggered.
///----------------------------------------------------------------

/// 🧠 [OverlayConflictStrategy] — Strategy object for each overlay that
/// defines its replacement logic and category identification.
class OverlayConflictStrategy {
  final OverlayPriority priority;
  final OverlayReplacePolicy policy;
  final OverlayCategory category;

  const OverlayConflictStrategy({
    required this.priority,
    required this.policy,
    required this.category,
  });
}

/// 🔺 Priority levels for overlays (used for conflict resolution)
// ⬇️ Least important, can be dropped easily
// 🔼 Important, takes precedence over lower ones
enum OverlayPriority { userDriven, normal, high, critical }

/// 🏷️ Categorizes overlays by their visual or functional purpose
enum OverlayCategory { banner, dialog, snackbar, error }

/// 🔐 Defines whether overlay can be dismissed externally
enum OverlayDismissPolicy {
  dismissible, // ✋ Tappable/cancellable
  persistent, // 🔒 Stays until dismissed programmatically
}

/// 🤝 Rules for resolving overlay collisions or duplicates
enum OverlayReplacePolicy {
  waitQueue, // ⏳ Wait in queue until current one is dismissed
  forceReplace, // 🔁 Always replace current overlay
  forceIfSameCategory, // 🔁 Replace if same category (e.g. two dialogs)
  forceIfLowerPriority, // 🔁 Replace only if new has higher priority
  dropIfSameType, // 🚫 Ignore if same type already visible
}

/// 📌 Specifies how to display an error in UI
enum ShowAs { banner, snackbar, dialog, infoDialog }

/// 🎚️ [OverlayBlurLevel] — Custom blur intensity levels for overlays
/// - Can override default blur defined via [ShowAs]
/// ────────────────────────────────────────────────────────────────
enum OverlayBlurLevel {
  soft, // Light blur, minimal distraction
  medium, // Balanced blur for dialogs/snackbars
  strong, // Strong blur for attention-grabbing modals
}
