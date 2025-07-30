/// 🔺 Priority levels for overlays (used for conflict resolution)
// ⬇️ Least important, can be dropped easily
// 🔼 Important, takes precedence over lower ones
//
enum OverlayPriority { userDriven, normal, high, critical }

////
////

/// 🏷️ Categorizes overlays by their visual or functional purpose
//
enum OverlayCategory { banner, dialog, snackbar, error }

////
////

/// 🔐 Defines whether overlay can be dismissed externally
//
enum OverlayDismissPolicy {
  dismissible, // ✋ Tappable/cancellable
  persistent, // 🔒 Stays until dismissed programmatically
}

////
////

/// 🤝 Rules for resolving overlay collisions or duplicates
//
enum OverlayReplacePolicy {
  waitQueue, // ⏳ Wait in queue until current one is dismissed
  forceReplace, // 🔁 Always replace current overlay
  forceIfSameCategory, // 🔁 Replace if same category (e.g. two dialogs)
  forceIfLowerPriority, // 🔁 Replace only if new has higher priority
  dropIfSameType, // 🚫 Ignore if same type already visible
}

////
////

/// 📌 Specifies how to display an error in UI
//
enum ShowAs { banner, snackbar, dialog, infoDialog }

////
////

/// 🎚️ [OverlayBlurLevel] — Custom blur intensity levels for overlays
/// - Can override default blur defined via [ShowAs]
//
enum OverlayBlurLevel {
  soft, // Light blur, minimal distraction
  medium, // Balanced blur for dialogs/snackbars
  strong, // Strong blur for attention-grabbing modals
}
