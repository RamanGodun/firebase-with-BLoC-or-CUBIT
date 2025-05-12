import 'package:flutter/material.dart';

import '../../../app_config/bootstrap/di_container.dart';
import 'overlay_dsl_x.dart';
import 'overlay_dispatcher/overlay_dispatcher_contract.dart';

/// 🎯 [OverlayContextX] — Unified extension for overlay DSL and dispatcher access
/// ✅ Use `context.overlay` to access the overlay controller
/// ✅ Use `context.overlayDispatcher` to enqueue custom overlay actions
//-------------------------------------------------------------

extension OverlayContextX on BuildContext {
  /// ⚡ DSL entry point — controller with banner/snackbar/dialog helpers
  OverlayController get overlay => OverlayController(this);

  /// 🔌 Direct access to [IOverlayDispatcher] from DI
  IOverlayDispatcher get overlayDispatcher => di<IOverlayDispatcher>();
}
