import 'dart:async' show StreamSubscription;

import 'package:flutter/material.dart' show BuildContext, OverlayState;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../overlay_dispatcher/overlay_state_bridge.dart';
import '../overlay_entries/_overlay_entries.dart';

/// 📦 [OverlayQueueItem] — Internal holder for enqueued overlays.
/// ✅ Binds [OverlayState] with a specific [OverlayUIEntry] for insertion.
final class OverlayQueueItem {
  final OverlayState overlay;
  final OverlayUIEntry request;
  const OverlayQueueItem({required this.overlay, required this.request});
}

/// 🧩 [OverlayStatusCubit] — Manages current overlay visibility state.
/// ✅ Used to propagate `isOverlayActive` from [OverlayDispatcher] to UI logic (e.g., disabling buttons).
final class OverlayStatusCubit extends Cubit<bool> {
  late final StreamSubscription _sub;

  OverlayStatusCubit() : super(false) {
    _sub = OverlayStateBridge.stream.listen((event) => emit(event));
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    return super.close();
  }
}

/// 🧠 [OverlayStatusX] — Extension for accessing overlay activity status from [BuildContext].
/// ⚠️ Note: For read-only checks only. For reactive usage, prefer listening to [OverlayStatusCubit] via BlocBuilder.
extension OverlayStatusX on BuildContext {
  bool get overlayStatus => read<OverlayStatusCubit>().state;
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
