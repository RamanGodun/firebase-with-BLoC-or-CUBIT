import 'package:flutter/material.dart';

import '../../../../app_bootstrap_and_config/di_container/di_container_initializaion.dart';
import '../overlay_dispatcher/_overlay_dispatcher.dart';

/// 🛠️ [OverlayUtils] — utility class for overlay-related helpers
/// ✅ Dismisses current overlay before executing the given action
///
abstract final class OverlayUtils {
  ///---------------------------
  OverlayUtils._();

  /// 🔁 Dismisses the currently visible overlay (if any) and executes [action]
  static VoidCallback dismissAndRun(VoidCallback action, BuildContext context) {
    return () {
      final dispatcher = di<OverlayDispatcher>();
      dispatcher.dismissCurrent(force: true);

      action.call();
    };
  }

  //
}
