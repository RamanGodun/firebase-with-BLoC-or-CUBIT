library;

/// 🧭 [UserDrivenOverlayType] — Declares user-initiated overlay categories
/// - Used by [OverlayQueueManager] for per-type queueing
/// - Mapped to [OverlayTask] subclasses (e.g. BannerOverlayTask)
//----------------------------------------------------------

enum UserDrivenOverlayType {
  banner,
  dialog,
  snackbar,
  // tooltip,
  // toast,
  // systemNotification,
}

/// 🎯 [AnimationPlatform] — Target platform for animation engine resolution
/// - Mapped from [TargetPlatform] via `.toAnimationPlatform()`
/// - Passed into [AnimationHost] for engine selection
//----------------------------------------------------------

enum AnimationPlatform { android, ios, adaptive }
