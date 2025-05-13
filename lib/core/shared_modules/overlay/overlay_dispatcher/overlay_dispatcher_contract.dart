import 'package:flutter/material.dart';
import '../presentation/overlay_entries/_overlay_entries.dart';

/// 📄 [IOverlayDispatcher] — Contract for the centralized overlay queue manager
/// ✅ Used by both the real and mock implementations to abstract dispatch logic
//-------------------------------------------------------------

abstract interface class IOverlayDispatcher {
  /// 🧩 Adds a request to the queue and initiates processing if idle
  void enqueueRequest(BuildContext context, OverlayUIEntry request);

  /// 🚫 Dismisses the currently active overlay and optionally clears the queue
  Future<void> dismissCurrent({bool clearQueue = false});

  /// 🧼 Clears all pending overlay requests from the queue
  void clearAll();

  /// 🧼 Clears all overlay requests associated with a given [context]
  void clearByContext(BuildContext context);
}
