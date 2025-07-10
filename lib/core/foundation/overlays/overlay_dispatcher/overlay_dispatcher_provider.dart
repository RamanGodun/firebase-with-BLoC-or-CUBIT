/*
! this is for apps, that use Riverpod

import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '_overlay_dispatcher.dart';

/// 🧠 [overlayDispatcherProvider] — Provides [OverlayDispatcher]
/// and syncs its activity with [overlayStatusProvider].

final overlayDispatcherProvider = Provider<OverlayDispatcher>((ref) {
  //----------------------------------------------------------------
  return OverlayDispatcher(
    onOverlayStateChanged: ref.read(overlayStatusProvider.notifier).update,
  );
});

///

/// 🧩 [overlayStatusProvider] — Manages current overlay visibility state.
/// ✅ Used to propagate `isOverlayActive` from [OverlayDispatcher] to UI logic (e.g., disabling buttons).

final overlayStatusProvider =
    StateNotifierProvider<OverlayStatusNotifier, bool>((ref) {
      //--------------------------------------------------------
      return OverlayStatusNotifier();
    });

final class OverlayStatusNotifier extends StateNotifier<bool> {
  OverlayStatusNotifier() : super(false);
  void update(bool isActive) => state = isActive;
}

/*
! 📌 Usage:
final dispatcher = ref.read(overlayDispatcherProvider);
final isVisible = ref.watch(overlayStatusProvider); // or ref.isOverlayActive
 */

///

///

/// 🧠 [OverlayStatusX] — Extension for accessing overlay activity status from [BuildContext].
/// ⚠️ Note: For read-only checks only. For reactive usage, prefer listening to [OverlayStatusCubit] via BlocBuilder.

extension OverlayStatusX on WidgetRef {
  //-----------------------------------
  bool get isOverlayActive => watch(overlayStatusProvider);
}


 */
