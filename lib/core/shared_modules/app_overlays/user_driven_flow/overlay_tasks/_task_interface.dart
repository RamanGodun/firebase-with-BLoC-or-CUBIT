import '../../../animation_engines/_animation_engine_factory.dart';

/// 🧩 [OverlayTask] — Abstract base for user-driven overlays
/// - Represents an executable overlay operation (snackbar, dialog, etc.)
/// - Used by [OverlayQueueManager] for queuing and scheduling
/// - Implemented by all user-driven overlays (e.g. [SnackbarOverlayTask])
// ----------------------------------------------------------------------

abstract base class OverlayTask {
  /// 🏷️ Overlay type (snackbar, banner, dialog) used for queue separation
  UserDrivenOverlayType get type;

  /// ⏱️ How long the overlay should stay on screen (zero = manual dismiss)
  Duration get duration;

  /// 🚀 Executes the overlay: builds, animates, and inserts into the overlay tree
  Future<void> show();
}
