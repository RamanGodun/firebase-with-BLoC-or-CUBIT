import 'package:flutter/material.dart';

import '../../overlay_dispatcher/conflicts_strategy/conflicts_strategy.dart';

/// ✳️ [IOverlayEntry] — Interface for dispatcher-compatible overlay entries
/// ✅ Used to mock entries in unit tests (instead of real UI widgets)
/// ✅ Contains only required contract methods (duration, strategy, build)
/// ✅ Internal: all production entries must still extend [OverlayUIEntry]
///
/// 💡 Example use case:
/// ```dart
/// final mockEntry = _FakeEntry(); // implements IOverlayEntry
/// dispatcher.enqueueRequest(mockContext, mockEntry);
/// expect(dispatcher.isProcessing, true);
/// ```
///
/// 🔐 [OverlayUIEntry] implements this implicitly; do not override in production code directly.
abstract interface class IOverlayEntry {
  Duration get duration;
  OverlayConflictStrategy get strategy;
  Widget build(BuildContext context);
}
